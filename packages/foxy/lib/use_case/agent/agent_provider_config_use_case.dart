import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:signals/signals.dart';

/// Persists the user's Responses-compatible provider settings in
/// `config.yaml`.
///
/// The API key is stored in plaintext next to the database credentials for
/// now; OS keychain storage is a future hardening step.
class AgentProviderConfigUseCase {
  static const _baseUrlKey = 'agent_base_url';

  static const _apiKeyKey = 'agent_api_key';
  static const _modelKey = 'agent_model';
  final ConfigUtil _configUtil;
  final _provider = signal<AgentProviderConfig?>(null);

  AgentProviderConfigUseCase(this._configUtil);

  ReadonlySignal<AgentProviderConfig?> get provider => _provider;

  /// Loads the saved provider, or `null` when base URL or model is missing.
  Future<AgentProviderConfig?> load() async {
    final previous = _provider.peek();
    final config = await _configUtil.load();
    final current = _provider.peek();
    if (!identical(previous, current)) return current;

    final baseUrl = config[_baseUrlKey];
    final model = config[_modelKey];
    if (baseUrl is! String ||
        baseUrl.trim().isEmpty ||
        model is! String ||
        model.trim().isEmpty) {
      _provider.value = null;
      return null;
    }
    final apiKey = config[_apiKeyKey];
    final loaded = AgentProviderConfig(
      baseUrl: baseUrl.trim(),
      apiKey: apiKey is String ? apiKey.trim() : '',
      model: model.trim(),
    );
    _provider.value = loaded;
    return loaded;
  }

  Future<void> save(AgentProviderConfig provider) async {
    await _configUtil.update({
      _baseUrlKey: provider.baseUrl,
      _apiKeyKey: provider.apiKey,
      _modelKey: provider.model,
    });
    _provider.value = provider;
  }
}
