import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:path/path.dart' as p;

/// JSONL-backed persistence for agent chat sessions.
///
/// One append-only file per session under `<app dir>/session/<id>.jsonl`,
/// next to `config.yaml`. Line kinds:
/// - `{"type":"session", ...}`: session header;
/// - `{"type":"message", "role": ..., "text": ...}`: UI transcript row;
/// - `{"type":"item", "item": {...}}`: protocol `input` item, replayed on load
///   to continue the conversation.
///
/// Appends are serialized through [_pending]; a partially written trailing
/// line (hard kill during a write) is ignored on load, and a user message
/// whose protocol item never made it to disk is repaired on load.
class AgentSessionStore {
  static const _fileExtension = '.jsonl';

  static const _defaultTitle = '新会话';
  final Directory _root;

  Future<void> _pending = Future.value();

  AgentSessionStore({Directory? root})
    : _root = root ?? Directory(p.join(Directory.current.path, 'session'));

  Future<void> appendItem(String id, Map<String, Object?> item) =>
      _enqueue(() => _appendLine(id, {'type': 'item', 'item': item}));

  Future<void> appendMessage(String id, AgentChatRole role, String text) =>
      _enqueue(
        () => _appendLine(id, {
          'type': 'message',
          'role': role.name,
          'text': text,
        }),
      );

  Future<void> createSession(String id) => _enqueue(
    () => _appendLine(id, {
      'type': 'session',
      'id': id,
      'createdAt': DateTime.now().toIso8601String(),
    }),
  );

  /// Deletes one session file. Unlike appends this rethrows on failure so the
  /// UI can surface it.
  Future<void> deleteSession(String id) async {
    try {
      final file = _fileOf(id);
      if (await file.exists()) await file.delete();
    } catch (error) {
      LoggerUtil.instance.e('delete agent session failed: $error');
      rethrow;
    }
  }

  /// Lists session metadata, newest first. Reads only the file head needed to
  /// derive the title; full content loads on demand via [load].
  Future<List<AgentChatSessionMeta>> list() async {
    if (!await _root.exists()) return const [];
    final files = (await _root.list().toList())
        .whereType<File>()
        .where((file) => file.path.endsWith(_fileExtension))
        .toList();
    final metas = await Future.wait(files.map(_readMeta));
    final present = metas.whereType<AgentChatSessionMeta>().toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return present;
  }

  /// Loads one session, or `null` when the file does not exist.
  Future<AgentChatSession?> load(String id) async {
    final file = _fileOf(id);
    if (!await file.exists()) return null;
    final List<String> lines;
    try {
      lines = await file.readAsLines();
    } catch (error) {
      LoggerUtil.instance.e('read agent session failed: $error');
      return null;
    }
    final entries = lines
        .map(_decodeLine)
        .whereType<Map<String, Object?>>()
        .toList();
    final messages = entries
        .where((entry) => entry['type'] == 'message')
        .map(AgentChatMessage.fromJson)
        .toList();
    final items = entries
        .where((entry) => entry['type'] == 'item')
        .map((entry) => entry['item'])
        .whereType<Map<String, Object?>>()
        .map((item) => Map<String, Object?>.from(item))
        .toList();
    _repairTrailingUserItem(messages, items);
    final firstUser = messages.firstWhereOrNull(
      (message) =>
          message.role == AgentChatRole.user && message.text.trim().isNotEmpty,
    );
    final session = AgentChatSession(
      id: id,
      title: firstUser == null
          ? _defaultTitle
          : AgentChatSession.titleFrom(firstUser.text),
    );
    session.messages.addAll(messages);
    session.session.addItems(items);
    return session;
  }

  Future<void> _appendLine(String id, Map<String, Object?> line) async {
    if (!await _root.exists()) {
      await _root.create(recursive: true);
    }
    await _fileOf(id).writeAsString(
      '${jsonEncode(line)}\n',
      mode: FileMode.append,
      flush: true,
    );
  }

  Future<void> _enqueue(Future<void> Function() task) {
    final next = _pending
        .catchError((Object _) {})
        .then((_) => task())
        .catchError((Object error) {
          LoggerUtil.instance.e('agent session persistence failed: $error');
        });
    _pending = next;
    return next;
  }

  File _fileOf(String id) => File(p.join(_root.path, '$id$_fileExtension'));

  Future<AgentChatSessionMeta?> _readMeta(File file) async {
    try {
      final stat = await file.stat();
      return AgentChatSessionMeta(
        id: p.basenameWithoutExtension(file.path),
        title: await _readTitle(file),
        updatedAt: stat.modified,
      );
    } catch (error) {
      LoggerUtil.instance.w('read agent session meta failed: $error');
      return null;
    }
  }

  Future<String> _readTitle(File file) async {
    try {
      await for (final line
          in file
              .openRead()
              .transform(utf8.decoder)
              .transform(const LineSplitter())) {
        final entry = _decodeLine(line);
        if (entry == null) continue;
        if (entry['type'] != 'message' ||
            entry['role'] != AgentChatRole.user.name) {
          continue;
        }
        final text = entry['text'];
        if (text is String && text.trim().isNotEmpty) {
          return AgentChatSession.titleFrom(text);
        }
      }
    } catch (error) {
      LoggerUtil.instance.w('read agent session title failed: $error');
    }
    return _defaultTitle;
  }

  /// Synthesizes the protocol user item for a trailing user message that was
  /// persisted before the run could append its item (crash between send and
  /// the first model round).
  void _repairTrailingUserItem(
    List<AgentChatMessage> messages,
    List<Map<String, Object?>> items,
  ) {
    final lastUser = messages.lastWhereOrNull(
      (message) => message.role == AgentChatRole.user,
    );
    if (lastUser == null) return;
    final hasUserItem = items.any(
      (item) => item['role'] == 'user' && item['content'] == lastUser.text,
    );
    if (hasUserItem) return;
    items.add({'role': 'user', 'content': lastUser.text});
  }

  static Map<String, Object?>? _decodeLine(String line) {
    final trimmed = line.trim();
    if (trimmed.isEmpty) return null;
    try {
      final decoded = jsonDecode(trimmed);
      if (decoded is Map<String, Object?>) return decoded;
    } on FormatException {
      // A partially written trailing line is expected after a hard kill.
    }
    return null;
  }
}
