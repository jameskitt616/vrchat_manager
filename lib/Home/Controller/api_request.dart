import 'dart:convert';
import 'dart:io';
import 'dart:async';

main() async {
  String url =
      'https://api.vrchat.cloud/api/1/users/usr_8946e21e-7067-4287-ab2f-5f95906539fa';
  Map map = {
    'data': {'apikey': 'JlE5Jldo5Jibnk5O5hTx6XVqsJu4WJ26'},
  };

  print(await apiRequest(url, map));
}

Future<String> apiRequest(String url, Map jsonMap) async {
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}
