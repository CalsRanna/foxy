import 'package:foxy_agent/foxy_agent.dart';

/// Wires one provider configuration and the read-only toolset into a
/// [FoxyAgent] for a single conversation run.
///
/// The caller owns the returned event stream and must [close] the use case
/// when the run ends or the page is disposed.
class AgentChatUseCase {
  AgentChatUseCase({
    required AgentProviderConfig provider,
    required TableCatalog catalog,
    required ReadOnlyDataSource dataSource,
  }) : _agent = FoxyAgent(
         provider: provider,
         instructions: readOnlyAssistantInstructions,
         tools: createReadOnlyTools(catalog: catalog, dataSource: dataSource),
       );

  final FoxyAgent _agent;

  Stream<AgentEvent> run(AgentSession session, String message) =>
      _agent.run(session, message);

  void close() => _agent.close();
}
