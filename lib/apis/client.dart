import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

final httpClient = new HttpClient();
const host = "http://8.131.96.86";

Future<String> sendGetRequest(String url) async {
  return http.Client().get(url).then((http.Response response) => response.body);
}

Future<String> sendPostRequest(String url, Object body) async {
  String result;
  try {
    var request = await httpClient.postUrl(Uri.parse(url));
    request.write(body);
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      result = data['origin'];
    } else {
      result = 'Error getting IP address:\nHttp status ${response.statusCode}';
    }
  } catch (exception) {
    result = 'Failed getting IP address';
  }
  return result;
}
