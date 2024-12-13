import "../model/model.dart";
import 'package:http/http.dart'as http;

class HttpService {
  static Future<List<Welcome>> fetchProducts() async {
    var response = await http.get(
        Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      var data = response.body;
      return welcomFromJson(data);
    } else {
      throw Exception();
    }
  }
}

