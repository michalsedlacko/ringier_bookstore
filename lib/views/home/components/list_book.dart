import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pager/pager.dart';
import 'package:ringier_bookstore/models/book.dart';
import 'package:ringier_bookstore/router/page_transition.dart';
import 'package:ringier_bookstore/views/home/bloc/book_list_bloc.dart';

import '../book_detail_view.dart';

class ListBook extends StatefulWidget {
  final String dataType;
  const ListBook({Key? key, required this.dataType}) : super(key: key);

  @override
  State<ListBook> createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));
  }

  void afterBuild(BuildContext context) {
    final BookListBloc bookListBloc = context.read<BookListBloc>();
    bookListBloc.add(BookListEventGetNewRelease());
  }

  @override
  Widget build(BuildContext context) {
    BookListBloc bookListBloc = context.read<BookListBloc>();
    return BlocBuilder<BookListBloc, BookListState>(
      bloc: context.read<BookListBloc>(),
      builder: (context, state) {
        if (state is BookListInitial) {
          return Container();
        } else if (state is BookListHasData) {
          List<Book> books = state.listBooks;
          List<Widget> childrenView = [];
          childrenView.add(Expanded(
              child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 300,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(books[index].image!),
                                    fit: BoxFit.cover)),
                          )
                        ]),
                    Expanded(
                        child: Container(
                      margin:
                          const EdgeInsets.only(top: 40, left: 10, bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            books[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(books[index].subtitle,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(
                            height: 20,
                            width: 10,
                          ),
                          Text('Isbn13: ${books[index].isbn13}',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(
                            height: 20,
                            width: 10,
                          ),
                          Text('price: ${books[index].price!}',
                              style: Theme.of(context).textTheme.titleMedium),
                          Expanded(
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                          context,
                                          PageTransition(
                                              child: BookDetailView(
                                                  isbn: books[index].isbn13),
                                              type: PageTransitionType.fade));
                                    },
                                    child: const Text('Detail'))
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              );
            },
          )));
          if (state.totalItem > 0 &&
              state.listBooks.length != 20 &&
              widget.dataType == 'list') {
            childrenView.add(Pager(
              totalPages: (state.totalItem / 10).ceil(),
              currentPage: state.currentPage,
              pagesView: 5,
              currentItemsPerPage: 10,
              onPageChanged: (page) {
                bookListBloc
                    .add(BookListEventSearch(query: state.query, page: page));
              },
            ));
          }
          return Expanded(
            child: Column(
              children: childrenView,
            ),
          );
        } else if (state is BookListError) {
          return Container();
        }
        return Container();
      },
    );
  }
}
