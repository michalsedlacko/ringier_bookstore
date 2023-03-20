import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringier_bookstore/common/utis.dart';
import 'package:ringier_bookstore/components/search_text_field.dart';
import 'package:ringier_bookstore/config/constant.dart';
import 'package:ringier_bookstore/views/home/bloc/book_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/list_book.dart';

///
/// [dataType] list or list-new-release
class HomeScreen extends StatelessWidget {
  final String dataType;

  const HomeScreen({Key? key, this.dataType = 'list'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnChildren = [];
    if (dataType == 'list') {
      columnChildren.add(const SearchWidget());
    }
    columnChildren.add(ListBook(
      dataType: dataType,
    ));
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: BlocProvider<BookListBloc>(
        key: Key(getRandomString(15)),
        create: (context) => BookListBloc(),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columnChildren,
        ),
      ),
    ));
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookListBloc bookListBloc = context.read<BookListBloc>();
    return SearchTextField(
      onChanged: (value) {
        bookListBloc.add(BookListEventSearch(query: value));
      },
    );
  }
}
