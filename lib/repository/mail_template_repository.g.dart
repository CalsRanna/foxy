// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_template_repository.dart';

final class MailTemplateFilter {
  final String id;
  final String subject;

  const MailTemplateFilter({this.id = '', this.subject = ''});

  factory MailTemplateFilter.fromJson(Map<String, dynamic> json) {
    return MailTemplateFilter(
      id: json['id']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
    );
  }

  MailTemplateFilter copyWith({String? id, String? subject}) {
    return MailTemplateFilter(
      id: id ?? this.id,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'subject': subject};
  }
}
