class Episode {
  final String title;
  final String url;
  final String category;
  final String description;

  const Episode({
    required this.title,
    required this.url,
    required this.category,
    this.description = '',
  });
}
