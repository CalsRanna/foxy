/// 页面文本模型
class PageText {
  int id = 0;
  String text = '';

  PageText();

  PageText.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    text = json['Text'] ?? json['text'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Text': text,
    };
  }
}