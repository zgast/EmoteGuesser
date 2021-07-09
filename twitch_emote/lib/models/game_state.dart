import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:quiver/async.dart';
import 'package:twitch_emote/backend/api_wrapper.dart';
import 'package:twitch_emote/models/app_state.dart';
import 'package:twitch_emote/models/emote_pic.dart';
import 'package:twitch_emote/models/game_type.dart';

const timeGameLength = Duration(seconds: 22);
const streakLengthPerImage = Duration(seconds: 8);

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

  bool loading = true;

  int _streakLength = 0;
  int get streakLength => _streakLength;
  set streakLength(int tryCount) {
    _streakLength = tryCount;
    notifyListeners();
  }

  getNewImage() async {
    _currentPic = null;
    loading = true;
    notifyListeners();
    var pic = await ApiWrapper.instance.getRandomPic();
    _currentPic = pic;
    loading = false;
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
    try {
      if (_countDownSubscription != null) _countDownSubscription.cancel();
      if (_timer != null) _timer.cancel();
    } catch (e) {
      // Timer was already cancelled
    }
    _remainingSeconds = 0;
    _streakLength = 0;
    type = GameType.NONE;
  }

  StreamSubscription<CountdownTimer> _countDownSubscription;
  CountdownTimer _timer;

  VoidCallback _onFinish;

  // Just the number for the UI, does not get used to check anything
  int _remainingSeconds = 0;
  int get remainingSeconds => _remainingSeconds;

  startGame(GameType type, {VoidCallback onFinish}) async {
    _type = type;
    await getNewImage();
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

      // Not using the callback function _countDownSubscription.onDone to
      // be able to stop and restart a new timer, since _countDownSubscription.onDone
      // is called, whenever you cancel the timer by hand...
      if (data.remaining.inSeconds == 0) {
        onFinish?.call();
        resetGame();
      }
    });

    _onFinish = onFinish;
  }
}
