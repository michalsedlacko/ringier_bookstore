part of 'book_list_bloc.dart';

abstract class BookListState extends Equatable {
  const BookListState() : super();

  @override
  List<Object> get props => [];
}

class BookListInitial extends BookListState {}

class BookListLoading extends BookListState {}

class BookListError extends BookListState {}

class BookListEmpty extends BookListState {}

class BookListHasData extends BookListState {
  final List<Book> listBooks;
  final int currentPage;
  final int totalItem;
  final String query;

  const BookListHasData(
      {required this.listBooks,
      this.currentPage = 1,
      this.totalItem = 0,
      this.query = ''});

  @override
  List<Object> get props => [listBooks, currentPage, totalItem, query];

  @override
  String toString() =>
      listBooks.toString() +
      currentPage.toString() +
      totalItem.toString() +
      query;
}
