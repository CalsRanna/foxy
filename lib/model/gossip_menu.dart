class GossipMenu {
  int menuId = 0;
  int textId = 0;

  GossipMenu();

  GossipMenu.fromJson(Map<String, dynamic> json) {
    menuId = json['MenuID'] ?? json['menuid'] ?? 0;
    textId = json['TextID'] ?? json['textid'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {'MenuID': menuId, 'TextID': textId};
  }
}
