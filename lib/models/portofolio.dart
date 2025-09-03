class Portofolio {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String image; 
  final String category;
  final String projectLink;

  Portofolio({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.projectLink,
  });

  factory Portofolio.fromMap(Map<String, dynamic> map) {
    return Portofolio(
      id: map['_id'] ?? '',
      userId: map['user'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      projectLink: map['project_link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user': userId,
      'title': title,
      'description': description,
      'image': image,
      'category': category,
      'project_link': projectLink,
    };
  }
}