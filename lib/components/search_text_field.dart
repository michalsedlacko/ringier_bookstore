import 'package:flutter/material.dart';
import 'package:ringier_bookstore/common/utis.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String value)? onChanged;

  const SearchTextField({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Debouncer<String> debauncer;
    if (onChanged != null) {
      debauncer = Debouncer(const Duration(milliseconds: 350), onChanged!);
    }

    return TextField(
      decoration: const InputDecoration(suffixIcon: Icon(Icons.search)),
      onChanged: (value) {
        if (onChanged != null) {
          debauncer.value = value;
        }
      },
    );
  }
}
