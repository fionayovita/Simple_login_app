import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/api/api_service.dart';
import 'package:flutter_login_app/model/user_model.dart';

enum ResultState { Loading, NoData, HasData, Error }

class UserProvider extends ChangeNotifier {
  final ApiService apiService;

  UserProvider({required this.apiService}) {
    fetchDataUser();
  }

  UserProvider getUsers() {
    fetchDataUser();
    return this;
  }

  late List<ListUser> _resultUser;

  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<ListUser> get resultUser => _resultUser;

  ResultState get state => _state;

  Future<dynamic> fetchDataUser() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final userData = await ApiService.fetchDataUser();
      if (userData.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        _resultUser = userData;
        notifyListeners();
        return _resultUser = userData;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
    // _userModel = await ApiService.fetchDataUser();
    // _resultUser = _userModel;
    // notifyListeners();
    // return _resultUser = _userModel;
  }
}
