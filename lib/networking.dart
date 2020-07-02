import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url, this.headers);
  String url;
  Map<String, String> headers;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
}
