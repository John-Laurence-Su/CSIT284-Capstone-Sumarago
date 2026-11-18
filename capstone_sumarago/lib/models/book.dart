class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.year,
    this.isbn,
    this.description = '',
  });

  /// e.g. BK-001
  final String id;
  final String title;
  final String author;
  final String genre;
  final int year;
  final String? isbn;
  final String description;
}
