import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ringier_bookstore/config/constant.dart';
import 'package:ringier_bookstore/models/book.dart';
import 'package:ringier_bookstore/services/app_api.dart';

class BookDetailView extends StatefulWidget {
  final String isbn;
  const BookDetailView({Key? key, required this.isbn}) : super(key: key);

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  final AppApi api = AppApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Text('Close'),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(width: double.infinity, height: 20),
            FutureBuilder<Book>(
              future: api.getBookByIsbn(widget.isbn),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                } else if (snapshot.hasData) {
                  Book book = snapshot.data!;
                  List<Widget> pdfWidgets = [];
                  if (book.pdf != null) {
                    pdfWidgets.add(const SizedBox(height: 20));
                    book.pdf!.forEach((key, value) {
                      pdfWidgets.add(
                        SelectableText('$key: $value',
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    });
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 350,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(book.image!),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 35,
                                    width: double.infinity,
                                  ),
                                  SelectableText(
                                    book.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(book.subtitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(
                                    height: 20,
                                    width: 10,
                                  ),
                                  Text(
                                      'Author: ${book.authors!}, Publisher: ${book.publisher!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(
                                      'isbn10: ${book.isbn10!}, isbn10: ${book.isbn10!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(
                                      'Pages: ${book.pages!}, Year: ${book.year!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text('Rating: ${book.rating!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const SizedBox(
                                    height: 10,
                                    width: double.infinity,
                                  ),
                                  Text('Cena: ${book.price!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 45, top: 10, bottom: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Decriptions: ${book.desc!}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                ...pdfWidgets
                              ]),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    )));
  }
}
