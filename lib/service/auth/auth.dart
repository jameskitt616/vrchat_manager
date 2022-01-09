import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../ui/login_page.dart';
import '../../ui/home_temp.dart';
import '../../ui/home.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

dynamic homeState = const LoginPage();


Future<void> checkIfAlreadyAuthenticated() async {
  const storage = FlutterSecureStorage();

  //TODO: check if cookie is expired and delete
  // storage.delete(key: 'cookie');
  // String? expiresAt = await storage.read(key: 'Expires');
  // String? maxAge = await storage.read(key: 'Max-Age');

  String? cookies = await storage.read(key: 'cookie');

  if (cookies == null) {
    print('LoginPage');
    homeState = const LoginPage();
  } else {
    print('Home');
    // homeState = const HomePage();
    homeState = const Home();
  }
}

Future<bool> login(String username, String password) async {


  print('login function');
  // final api = VrchatDart(userAgent: 'vrchat_dart_example');
  //
  // final loginResponse = await api.auth.login(
  //   username: '',
  //   password: '',
  // );
  //
  // if (loginResponse.error != null) {
  //   print('authError');
  //   print(loginResponse.error);
  // } else if (loginResponse.requiresTwoFactorAuth) {
  //   print('requiresTwoFactorAuth');
  //   final twoFactorResponse = await api.auth.verify2fa('123456');
  //   if (twoFactorResponse.error == null) {
  //     print('2fa verification success');
  //   } else {
  //     print('2fa verification failure');
  //     print(twoFactorResponse.error);
  //   }
  // }
  //
  // if (api.auth.currentUser != null) {
  //   print('logged in');
  //   print(api.auth.currentUser?.username);
  // }





  const storage = FlutterSecureStorage();
  String? oldCookie = await storage.read(key: 'cookie');

  if (oldCookie != null) {
    return true;
  }

  //TODO: check to do if 2FA enabled
  final String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  final Uri url = Uri.https('api.vrchat.cloud', "/api/1/auth/user");
  final http.Response response = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  String? cookie = response.headers[HttpHeaders.setCookieHeader];
  if (cookie == null) {
    return false;
  }

  await storage.write(key: 'cookie', value: cookie);
  return true;
}

Future<void> logout() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: 'cookie');
}
