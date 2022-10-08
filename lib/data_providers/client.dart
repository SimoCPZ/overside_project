import 'package:http/http.dart' as http;

///Custom class used to call the API.

class ApiClient {
  Future<String> getProducts(List<int> ids) async {
    var response = await http.get(
      Uri.parse(
          'http://developer.overside.it/demo/api.php?ids=${ids.join(',')}'),
    );

    //check API errors
    if (response.statusCode != 200) {
      throw Exception('Request error');
    }

    return response.body;
  }
}
