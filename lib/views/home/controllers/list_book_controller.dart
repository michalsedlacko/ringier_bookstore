import 'package:flutter/material.dart';
import 'package:ringier_bookstore/models/book.dart';

class ListBookController extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => _books;

  void loadList() async {
    notifyListeners();
  }
}
