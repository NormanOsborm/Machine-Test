import 'package:http/http.dart' as http;

import '../model/model1.dart';

class HttService {
  static Future<List<Wel>> fetchProducts() async {
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      var data = response.body;
      return welcomFromJson(data);
    } else {
      throw Exception();
    }
  }
}
