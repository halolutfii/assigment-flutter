class PortofolioItem {
  String title;
  String category;
  DateTime? completion;
  String description;
  String image;
  String link;

  PortofolioItem({
    this.title = '',
    this.category = '',
    this.completion,
    this.description = '',
    this.image = '',
    this.link = '',
  });
}