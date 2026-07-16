class MailTemplateFilterEntity {
  final String id;
  final String subject;

  const MailTemplateFilterEntity({this.id = '', this.subject = ''});

  factory MailTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return MailTemplateFilterEntity(
      id: json['id'] ?? '',
      subject: json['subject'] ?? '',
    );
  }

  MailTemplateFilterEntity copyWith({String? id, String? subject}) {
    return MailTemplateFilterEntity(
      id: id ?? this.id,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'subject': subject};
}
