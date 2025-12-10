class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String category;
  final double price;
  final double rating;
  final int createdYear;
  final int pageCount;
  final String? pdfUrl;
  bool isDownloaded;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.rating,
    required this.createdYear,
    required this.pageCount,
    this.pdfUrl,
    this.isDownloaded = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdYear: json['createYear'] ?? 0,
      pageCount: json['pageCount'] ?? 0,
      pdfUrl: json['pdfFileName'],
      isDownloaded: json['is_downloaded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'image': imageUrl,
      'category': category,
      'price': price,
      'rating': rating,
      'created_year': createdYear,
      'page_count': pageCount,
      'pdf_url': pdfUrl,
      'is_downloaded': isDownloaded,
    };
  }
}
