import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;
  Network(this.url);
  Future getWeatherData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
