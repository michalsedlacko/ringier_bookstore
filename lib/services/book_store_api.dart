import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BookStoreApi {
  final String _apiUrl = 'https://api.itbook.store/1.0';

  _setHeaders() => {'Accept': 'application/json'};

  ///
  Future<Response> get(String path,
      {Client? client, Map<String, dynamic>? queryParams}) async {
    Uri url = Uri.parse(_apiUrl + path);
    if (queryParams != null) {
      url = url.replace(
        queryParameters: queryParams,
      );
    }
    if (client != null) {
      return await client.get(
        url,
        headers: _setHeaders(),
      );
    } else {
      return await http.get(url, headers: _setHeaders());
    }
  }
}
