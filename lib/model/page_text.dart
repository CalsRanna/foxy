/// 页面文本模型
class PageText {
  int id = 0;
  String text = '';
  int nextPageId = 0;
  int verifiedBuild = 0;

  PageText();

  PageText.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    text = json['Text'] ?? json['text'] ?? '';
    nextPageId = json['NextPageID'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Text': text,
      'NextPageID': nextPageId,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
