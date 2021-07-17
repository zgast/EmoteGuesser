class UserStats {
  String timeGames;
  String timeGuessed;
  String timeGlobal;
  String streakGames;
  String streakGuessed;
  String streakGlobal;

  UserStats({
    this.timeGames,
    this.timeGuessed,
    this.streakGames,
    this.streakGuessed,
    this.streakGlobal,
    this.timeGlobal,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    try {
      return UserStats(
        timeGames: json["timeGames"].toString(),
        timeGuessed: json["timeGuessed"].toString(),
        timeGlobal: json["timeGlobal"].toString(),
        streakGames: json["streakGames"].toString(),
        streakGuessed: json["streakGuessed"].toString(),
        streakGlobal: json["streakGlobal"].toString(),
      );
    } catch (e) {
      return null;
    }
  }
}
