import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ringier_bookstore/models/api_list_response.dart';
import 'package:ringier_bookstore/models/book.dart';
import 'package:ringier_bookstore/services/app_api.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final AppApi api = AppApi();

  BookListBloc() : super(BookListInitial()) {
    on<BookListEvent>((event, emit) async {
      if (event is BookListEventGetNewRelease) {
        try {
          emit.call(BookListLoading());
          emit.call(BookListError());
          List<Book> response = await api.getNewRelease();
          emit.call(
              BookListHasData(listBooks: response, totalItem: response.length));
        } catch (e) {
          emit.call(BookListError());
        }
      } else if (event is BookListEventSearch) {
        try {
          emit.call(BookListLoading());
          ApiListResponse<List<Book>> apiResponse =
              await api.searchBooks(event.query, page: event.page);
          emit.call(BookListHasData(
              listBooks: apiResponse.data,
              currentPage: apiResponse.page,
              totalItem: apiResponse.total,
              query: event.query));
        } catch (e) {
          emit.call(BookListError());
        }
      }
    });
  }
}
