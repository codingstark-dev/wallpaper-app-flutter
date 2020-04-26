import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

class NetworkAPI {
  NetworkAPI(this.url);

  final String url;

  Future getData() async {
    Map<String, String> header = {
      "Content-Type": "application/json",
      'User-agent': 'your bot 0.1'
    };

    Response response = await Dio().get(
      url,
      queryParameters: header,
    );

    // return if only request is successful
    if (response.statusCode == 200) {
      dynamic data = response.data;
      // print(data);
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
