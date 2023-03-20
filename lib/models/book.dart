import 'package:json_annotation/json_annotation.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  @JsonKey(required: true)
  String title;
  String subtitle;
  String? authors;
  String? publisher;
  String? isbn10;
  @JsonKey(required: true)
  String isbn13;
  @JsonKey(
    fromJson: _stringToInt,
  )
  int? pages;
  @JsonKey(
    fromJson: _stringToInt,
  )
  int? year;
  String? rating;
  String? desc;
  String? price;
  String? image;
  String? url;
  Map<String, String>? pdf;

  Book({
    required this.title,
    required this.subtitle,
    this.authors,
    this.publisher,
    this.isbn10,
    required this.isbn13,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.price,
    this.image,
    this.url,
  });

  static int? _stringToInt(String? value) {
    return (value != null && value.isNotEmpty) ? int.parse(value) : null;
  }

  Map<String, dynamic> toJson() => _$BookToJson(this);

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  @override
  String toString() {
    return toJson().toString();
  }
}
