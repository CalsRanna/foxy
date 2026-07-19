import 'package:foxy/entity/mail_template_entity.dart';

class MailTemplateKey {
  final int id;

  const MailTemplateKey({required this.id});

  factory MailTemplateKey.fromEntity(MailTemplateEntity entity) =>
      MailTemplateKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MailTemplateKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
