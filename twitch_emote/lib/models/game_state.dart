import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:twitch_emote/backend/api_wrapper.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/models/emote_pic.dart';
import 'package:twitch_emote/models/game_type.dart';

import 'package:quiver/async.dart';

const timeGameLength = Duration(seconds: 20);
const streakLengthPerImage = Duration(seconds: 6);

const increment = Duration(seconds: 1);

class GameState with ChangeNotifier {
  AppState _appState;

  GameState(AppState appState) {
    this._appState = appState;
  }

  EmotePic _currentPic;
  EmotePic get currentPic => _currentPic;

  GameType _type = GameType.NONE;
  GameType get type => _type;
  set type(GameType gameType) {
    _type = gameType;
    notifyListeners();
  }

  bool _loading = true;
  bool get loading => _loading;

  int _streakLength = 0;
  int get streakLength => _streakLength;
  set streakLength(int tryCount) {
    _streakLength = tryCount;
    notifyListeners();
  }

  getNewImage() async {
    _currentPic = null;
    _loading = true;
    notifyListeners();
    var pic = await ApiWrapper.instance.getRandomPic();
    _currentPic = pic;
    _loading = false;
    notifyListeners();
  }

  Future<bool> checkInput(String input) async {
    if (currentPic == null) return false;
    var correct = currentPic.checkName(input);
    if (correct) {
      streakLength += 1;
      notifyListeners();
      var remaining = _timer.remaining;
      // Cancel timer, because long image loading times could make View Pop
      _timer.cancel();
      _countDownSubscription.cancel();
      await getNewImage();
      if (type == GameType.STREAK) {
        _timer = CountdownTimer(streakLengthPerImage, increment);
        _setupCountdownListener(_onFinish);
      } else {
        _timer = CountdownTimer(remaining, increment);
        _setupCountdownListener(_onFinish);
      }
    }
    return correct;
  }

  resetGame() {
    ApiWrapper.instance.finishGame(_streakLength, type, _appState.loggedInUser);
    if (_countDownSubscription != null) _countDownSubscription.cancel();
    if (_timer != null) _timer.cancel();
    _streakLength = 0;
    type = GameType.NONE;
    getNewImage();
  }

  StreamSubscription<CountdownTimer> _countDownSubscription;
  CountdownTimer _timer;

  VoidCallback _onFinish;

  int _remainingSeconds = 0;
  int get remainingSeconds => _remainingSeconds;

  startGame(GameType type, {VoidCallback onFinish}) {
    _type = type;
    getNewImage();
    Duration gameLength;
    if (type == GameType.TIME)
      gameLength = timeGameLength;
    else
      gameLength = streakLengthPerImage;

    _timer = CountdownTimer(gameLength, increment);
    _setupCountdownListener(onFinish);
  }

  _setupCountdownListener(VoidCallback onFinish) {
    _countDownSubscription = _timer.listen(null);
    _countDownSubscription.onData((data) {
      _remainingSeconds = data.remaining.inSeconds;
      notifyListeners();
    });

    _onFinish = onFinish;
    _countDownSubscription.onDone(() {
      onFinish?.call();
      resetGame();
    });
  }
}
