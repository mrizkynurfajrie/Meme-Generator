import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Api {
  String baseUrl = 'https://api.imgflip.com/';

  Future<dynamic> apiJsonGet(
    String url,
  ) async {
    Map<String, String> headers = {
      'content-Type': 'application/json',
    };
    log('headers : $headers');
    log('api url : $baseUrl$url');

    http.Response r =
        await http.get(Uri.parse(baseUrl + url), headers: headers);
    var data = json.decode(r.body);
    log('status code : ${r.statusCode}');

    return data;
  }
}
