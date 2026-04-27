import 'package:flutter/widgets.dart';
import 'package:foxy/model/page_text.dart';
import 'package:foxy/model/page_text_locale.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PageTextDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = PageTextRepository();

  final idController = TextEditingController();
  final textController = TextEditingController();
  final nextPageIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final pageText = signal<PageText?>(null);
  final locales = signal<List<PageTextLocale>>([]);

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      pageText.value = await repository.find(id);
      _initControllers(pageText.value!);
      locales.value = await repository.getLocales(id);
    } catch (e, s) {
      logger.e('加载页面文本(ID=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(PageText pt) {
    idController.text = pt.id.toString();
    textController.text = pt.text;
    nextPageIdController.text = pt.nextPageId.toString();
    verifiedBuildController.text = pt.verifiedBuild.toString();
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collect();
      await repository.store(data);
      pageText.value = data;
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('页面文本已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> update(BuildContext context) async {
    final id = pageText.value?.id ?? 0;
    if (id == 0) return;
    try {
      final data = _collect();
      await repository.update(id, data);
      pageText.value = data;
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void pop() => routerFacade.goBack();

  PageText _collect() {
    final pt = PageText();
    pt.id = _parseInt(idController.text);
    pt.text = textController.text;
    pt.nextPageId = _parseInt(nextPageIdController.text);
    pt.verifiedBuild = _parseInt(verifiedBuildController.text);
    return pt;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  void dispose() {
    idController.dispose();
    textController.dispose();
    nextPageIdController.dispose();
    verifiedBuildController.dispose();
  }
}
