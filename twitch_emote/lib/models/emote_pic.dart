class EmotePic {
  final String name;
  final String url;

  const EmotePic(this.name, this.url);

  bool checkName(String input) {
    if (name.toLowerCase() == input.toLowerCase()) return true;
    return false;
  }

  factory EmotePic.fromJson(Map<String, dynamic> json) {
    try {
      return EmotePic(json["name"], json["url"]);
    } catch (e) {
      return null;
    }
  }
}
