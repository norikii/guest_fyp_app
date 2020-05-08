import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:guest_fyp_app/models/guest_user.dart';
import 'package:guest_fyp_app/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  int _statusCode;
  String _message;
  String _token;
  GuestUser _user;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null && _message == 'user is logged in') {
      return _token;
    }

    return null;
  }

  Future<void> signUp(String email, String password) async {
    const url = 'http://192.168.0.55:12345/user/guest/register';
    try {
      final response = await http.post(url, body: json.encode(
        {
          'email': email,
          'password': password,
        },
      )
      );
      final responseData = json.decode(response.body);
      if(responseData['error_code'] != null) {
        print(responseData['error_code']);
        throw HttpException(responseData['error_message']);
      }
    } catch(error) {
      print(error);
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    const url = 'http://192.168.0.55:12345/user/guest/login';
    try {
      final response = await http.post(url, body: json.encode(
        {
          'email': email,
          'password': password,
        },
      )
      );
      print(email);
      final responseData = json.decode(response.body);
      print(responseData);

      if(responseData['error_code'] != null) {
        throw HttpException(responseData['error_message']);
      }

      _token = json.decode(response.body)['payload']['token'];
      _message = json.decode(response.body)['payload']['message'];
      _user = GuestUser(
        id: json.decode(response.body)['payload']['user']['_id'],
        email: json.decode(response.body)['payload']['user']['email'],
      );
      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  void logout() {
    _token = null;
    _message = null;
    _user = null;
    notifyListeners();
  }
}