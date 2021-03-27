class Picture {
  String name;
  String URL;

  Picture({this.name, this.URL});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      name: json["name"],
      URL: json["url"],
    );
  }
}
