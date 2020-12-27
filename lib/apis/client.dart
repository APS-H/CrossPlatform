import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

final httpClient = new HttpClient();
// const host = "http://8.131.96.86:30808";
const host = "http://localhost:8080";

String withHost(String url) {
  return "$host$url";
}

// dart tips (https://www.yuque.com/wuhaoliang/dart/lnprt4)
//     中文乱码问题
//     在使用 flutter 时，可能会需要通过 http 服务请求 json 格式的数据时，当数据中包含中文时，可能涉及乱码情况，解决方法如下：
//     json.decode(utf8.decode(response.bodyBytes))
//     先通过 utf8.decode 直接对 reponse 进行解码而不是直接使用 json.decode 解码 response.body，这里可能是 dart 的 bug 也有可能是使用不当，我尝试了若干种方式来设置编码字符集，包括配置 encoding、传递 charset 请求头部字段等，均以失败告终
Future<String> sendGetRequest(String url) async => http.Client()
    .get(withHost(url))
    .then((http.Response response) => utf8.decode(response.bodyBytes));

Future<String> sendPostRequest(String url, Object body) async {
  String result;
  try {
    var request = await httpClient.postUrl(Uri.parse(withHost(url)));
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
