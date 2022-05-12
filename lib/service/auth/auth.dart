import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../ui/login_page.dart';
import '../../ui/home_temp.dart';
import '../../ui/home.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrchat_dart_generated/vrchat_dart_generated.dart';
import 'package:dio/dio.dart';

dynamic homeState = const LoginPage();


Future<void> checkIfAlreadyAuthenticated() async {
  const storage = FlutterSecureStorage();

  //TODO: check if cookie is expired and delete
  storage.delete(key: 'cookie');
  // String? expiresAt = await storage.read(key: 'Expires', aOptions: getAndroidOptions());
  // String? maxAge = await storage.read(key: 'Max-Age', aOptions: getAndroidOptions());

  String? cookies = await storage.read(key: 'cookie', aOptions: getAndroidOptions());

  // if (cookies == null) {
  homeState = const LoginPage();
  // } else {
  // homeState = const HomePage();
    // homeState = const Home();
  // }
}

AndroidOptions getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

Future<bool> login(String username, String password) async {

  // final vrchatDartGeneratedApi = VrchatDartGenerated();
  // final authApi = vrchatDartGeneratedApi.getAuthenticationApi();
  // final String email = 'service.feedbox@simplelogin.co'; // String | Filter by email.
  // final String displayName = 'DetachedSpace'; // String | Filter by displayName.
  // final String userId = userId_example; // String | Filter by UserID.
  // final String excludeUserId = ''; // String | Exclude by UserID.

  // try {
  //   final response2 = await authApi.checkUserExists(headers: {
  //     'Authorization':
  //     'Basic ${base64.encode(utf8.encode('$username:$password'))}'
  //   });
  //   // final response2 = await authApi.checkUserExists(email, displayName);
  //   print(response2);
  // } catch on DioError (e) {
  //   print("Exception when calling AuthenticationApi->checkUserExists: $e\n");
  // }

  // try {
  //   final response = await authApi.getCurrentUser(
  //     headers: {
  //     'Authorization':
  //     'Basic ${base64.encode(utf8.encode('username:password'))}'
  //     // 'Basic ${base64.encode(utf8.encode('$username:$password'))}'
  //     },
  //   );
  //
  // print(response.data);

  // I/flutter ( 3379): CurrentUser {
  // I/flutter ( 3379):   acceptedTOSVersion=7,
  // I/flutter ( 3379):   activeFriends=[],
  // I/flutter ( 3379):   allowAvatarCopying=true,
  // I/flutter ( 3379):   bio=,
  // I/flutter ( 3379):   bioLinks=[],
  // I/flutter ( 3379):   currentAvatar=avtr_c38a1615-5bf5-42b4-84eb-a8b6c37cbd11,
  // I/flutter ( 3379):   currentAvatarAssetUrl=https://api.vrchat.cloud/api/1/file/file_d7b814f6-a8a0-44f8-9c2f-492947e0ecae/4/file,
  // I/flutter ( 3379):   currentAvatarImageUrl=https://api.vrchat.cloud/api/1/file/file_0e8c4e32-7444-44ea-ade4-313c010d4bae/1/file,
  // I/flutter ( 3379):   currentAvatarThumbnailImageUrl=https://api.vrchat.cloud/api/1/image/file_0e8c4e32-7444-44ea-ade4-313c010d4bae/1/256,
  // I/flutter ( 3379):   dateJoined=2021-12-24,
  // I/flutter ( 3379):   developerType=none,
  // I/flutter ( 3379):   displayName=DetachedSpace,
  // I/flutter ( 3379):   emailVerified=true,
  // I/flutter ( 3379):   fallbackAvatar=avtr_1f54ee82-44c8-4528-9c2b-c16bd19dea9a,
  // I/flutter ( 3379):   friendGroupNames=[],
  // I/flutter ( 3379):   friendKey=434f410a4ad8d57975d638fd6bef40fe056de7b9f8c23321e51e935710936289,
  // I/flutter ( 3379):   friends=[],
  // I/flutter ( 3379):   hasBirthday=true,
  // I/flutter ( 3379):   hasEmail=true,
  // I/flutter ( 3379):   hasLoggedInFromClient=false,
  // I/flutter ( 3379):   hasPendingEmail=false,
  // I/flutter ( 3379):   homeLocation=,
  // I/flutter ( 3379):   id=usr_23388133-2601-4692-a060-10992e428db1,
  // I/flutter ( 3379):   isFriend=false,
  // I/flutter ( 3379):   lastLogin=2022-01-16 13:01:44.290Z,
  // I/flutter ( 3379):   lastPlatform=standalonewindow
  // I/flutter ( 3379): {error: {message: "No API Key provided!", status_code: 401}}


  // } on DioError catch (error) {
  //   final bodyJson = error.response?.data as Map<String, dynamic>?;
  //
  //   if (bodyJson?['requiresTwoFactorAuth'] != null) {
  //   // return AuthResponse(requiresTwoFactorAuth: true);
  //     print('requiresTwoFactorAuth: true');
  //   } else {
  //     print(error);
  //   // return AuthResponse(error: VrcError.fromDioError(error));
  //   }
  // }
  //
  // final friendsApi = vrchatDartGeneratedApi.getFriendsApi();
  //
  // try {
  //   final friendsResponse = await friendsApi.getFriends();
  //   print(friendsResponse);
  // } on DioError catch (error) {
  //   final bodyJson = error.response?.data as Map<String, dynamic>?;
  //   // {error: {message: "No API Key provided!", status_code: 401}}
  //     print(bodyJson);
  // }




//   final api = VrchatDart(userAgent: 'VRChat Dart Demo');
//
// // Step 2. Log in with authentication
//   final loginResponse = await api.auth.login(
//     username: 'username',
//     password: 'password',
//   );
//
//   print(loginResponse);
// // Step 3. Print out current user's username
//   if (api.auth.currentUser != null) {
//     print(api.auth.currentUser?.username);
//   }




  final api = VrchatDart(userAgent: 'vrchat_manager');
  // final api = VrchatDart(userAgent: 'vrchat_manager');

  final loginResponse = await api.auth.login(
    username: 'username',
    password: 'password',
  );
  if (loginResponse.error != null) {
    print('authError');
    print(loginResponse.error);
  } else if (loginResponse.requiresTwoFactorAuth) {
    print('requiresTwoFactorAuth');
    final twoFactorResponse = await api.auth.verify2fa('123456');
    if (twoFactorResponse.error == null) {
      print('2fa verification success');
    } else {
      print('2fa verification failure');
      print(twoFactorResponse.error);
    }
  }

  if (api.auth.currentUser != null) {
    print('logged in');
    print(api.auth.currentUser?.username);
  }

  // "error": {
  //   "message": "\"It looks like you're logging in from somewhere new! Check your email for a message from VRChat.\"",
  //   "status_code": 401
  // }



  const storage = FlutterSecureStorage();
  String? oldCookie = await storage.read(key: 'cookie', aOptions: getAndroidOptions());

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

  await storage.write(key: 'cookie', value: cookie, aOptions: getAndroidOptions());
  return true;
}

Future<void> logout() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: 'cookie', aOptions: getAndroidOptions());
}
