import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy_agent/foxy_agent.dart';

/// Persists the user's Responses-compatible provider settings in
/// `config.yaml`.
///
/// The API key is stored in plaintext next to the database credentials for
/// now; OS keychain storage is a future hardening step.
class AgentProviderConfigUseCase {
  AgentProviderConfigUseCase(this._configUtil);

  static const _baseUrlKey = 'agent_base_url';
  static const _apiKeyKey = 'agent_api_key';
  static const _modelKey = 'agent_model';

  final ConfigUtil _configUtil;

  /// Loads the saved provider, or `null` when base URL or model is missing.
  Future<AgentProviderConfig?> load() async {
    final config = await _configUtil.load();
    final baseUrl = config[_baseUrlKey];
    final model = config[_modelKey];
    if (baseUrl is! String || baseUrl.trim().isEmpty) return null;
    if (model is! String || model.trim().isEmpty) return null;
    final apiKey = config[_apiKeyKey];
    return AgentProviderConfig(
      baseUrl: baseUrl.trim(),
      apiKey: apiKey is String ? apiKey.trim() : '',
      model: model.trim(),
    );
  }

  Future<void> save(AgentProviderConfig provider) {
    return _configUtil.update({
      _baseUrlKey: provider.baseUrl,
      _apiKeyKey: provider.apiKey,
      _modelKey: provider.model,
    });
  }
}
