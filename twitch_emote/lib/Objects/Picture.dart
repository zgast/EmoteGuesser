class Picture {
  final String name = null;
  final String URL = null;

  Picture({this.name, this.URL});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      name: json['name'],
      URL: json['URL'],
    );
  }
  String getName() {
    return this.name;
  }
}
