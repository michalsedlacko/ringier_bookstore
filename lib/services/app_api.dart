import 'package:http/http.dart';
import 'package:ringier_bookstore/models/api_list_response.dart';
import 'package:ringier_bookstore/models/book.dart';
import 'package:ringier_bookstore/services/book_store_api.dart';
import 'dart:convert';

class AppApi {
  final BookStoreApi bookApi = BookStoreApi();

  Future<List<Book>> getBooks() async {
    List<Book> books = [];
    try {} catch (e) {}
    return books;
  }

  Future<List<Book>> getNewRelease() async {
    List<Book> books = [];
    try {
      Response response = await bookApi.get('/new');
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        int total = int.parse(body['total']);
        if (total > 0) {
          Iterable list = body['books'];
          books = list.map((model) => Book.fromJson(model)).toList();
        }
      }
      return books;
    } catch (e) {
      throw Exception('Something went wrong!');
    }
  }

  Future<Book> getBookByIsbn(String isbn) async {
    try {
      Response response = await bookApi.get('/books/$isbn');
      Map<String, dynamic> body = json.decode(response.body);
      Book book = Book.fromJson(body);
      return book;
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  Future<ApiListResponse<List<Book>>> searchBooks(String query,
      {int page = 1}) async {
    ApiListResponse<List<Book>> appResponse =
        ApiListResponse(data: [], page: page);
    try {
      Response response = await bookApi.get('/search/$query/$page');
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        int total = int.parse(body['total']);
        if (total > 0) {
          Iterable list = body['books'];
          appResponse.data = list.map((model) => Book.fromJson(model)).toList();
          appResponse.total = total;
        }
      }
      return appResponse;
    } catch (e) {
      throw Exception('Something went wrong!');
    }
  }
}
