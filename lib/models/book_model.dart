class Book {
  final String id;
  final String name;
  final String author;
  final String publisher;
  final String datePublished;

  Book({required this.id, required this.name, required this.author, 
        required this.publisher, required this.datePublished});

  // Convert a Map (from Firebase) into a Book object
  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      author: data['author'] ?? '',
      publisher: data['publisher'] ?? '',
      datePublished: data['datePublished'] ?? '',
    );
  }

  // Convert Book object into a Map to send to Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'publisher': publisher,
      'datePublished': datePublished,
    };
  }
}