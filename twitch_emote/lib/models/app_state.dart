import 'package:flutter/cupertino.dart';
import 'package:twitch_emote/backend/api_wrapper.dart';
import 'package:twitch_emote/helper/check.dart';
import 'package:twitch_emote/helper/save_managment.dart';
import 'package:twitch_emote/models/user.dart';

enum HomeState { LOADING, LOGIN, HOME, NO_CONNECTION }

class AppState extends ChangeNotifier {
  User _loggedInUser;
  HomeState _homeState = HomeState.LOADING;

  User get loggedInUser => _loggedInUser;

  HomeState get homeState => _homeState;

  AppState() {
    _initApp();
  }

  _initApp() async {
    var u = await SaveManagment.loadUser();
    if (u == null) {
      _homeState = HomeState.LOGIN;
      notifyListeners();
    } else {
      _loggedInUser = u;
      _homeState = HomeState.HOME;
      notifyListeners();
    }
  }

  Future<bool> checkConnection() async {
    var result = await Check.checkConnection();
    if (!result) {
      _homeState = HomeState.NO_CONNECTION;
      notifyListeners();
    }
    return result;
  }

  // Returns true if successful
  Future<bool> register(String name) async {
    try {
      var u = await ApiWrapper.instance.registerUser(name);
      if (u == null) {
        return false;
      }
      _loggedInUser = u;
      SaveManagment.saveUser(u);
    } catch (e) {
      return false;
    }

    _homeState = HomeState.HOME;
    notifyListeners();
    return true;
  }
}
