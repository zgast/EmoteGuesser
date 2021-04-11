class UserStats {
  String timeGames;
  String timeGuessed;
  String streakGames;
  String streakGuessed;

  UserStats(
      {this.timeGames, this.timeGuessed, this.streakGames, this.streakGuessed});

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      timeGames: json["timeGames"].toString(),
      timeGuessed: json["timeGuessed"].toString(),
      streakGames: json["streakGames"].toString(),
      streakGuessed: json["streakGuessed"].toString(),
    );
  }
}
