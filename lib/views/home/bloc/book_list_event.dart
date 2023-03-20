part of 'book_list_bloc.dart';

abstract class BookListEvent extends Equatable {
  const BookListEvent() : super();

  @override
  List<Object> get props => [];
}

class BookListEventInit extends BookListEvent {}

class BookListEventGetNewRelease extends BookListEvent {}

class BookListEventSearch extends BookListEvent {
  final String query;
  final int page;

  const BookListEventSearch({required this.query, this.page = 1});

  @override
  List<Object> get props => [query, page];

  @override
  String toString() => query;
}
