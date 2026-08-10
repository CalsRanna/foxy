import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {

  test('EmotesText 与引用 DBC Schema 对应 3.3.5.12340', () {
    final emotesText = DbcDefinitions.byTable['dbc_emotes_text']!;
    final emotes = DbcDefinitions.byTable['dbc_emotes']!;
    final textData = DbcDefinitions.byTable['dbc_emotes_text_data']!;
    expect(emotesText.fileName, 'EmotesText.dbc');
    expect(emotesText.schema.fields, hasLength(19));
    expect(emotes.fileName, 'Emotes.dbc');
    expect(textData.fileName, 'EmotesTextData.dbc');
    expect(textData.schema.fields, hasLength(18));
    expect(DbcDefinitions.requiredTableNames, contains('dbc_emotes_text_data'));
  });

}
