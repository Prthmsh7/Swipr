class Destination {
  final String name;
  final String image;
  final String description;
  final int budget;
  final int days;

  Destination({
    required this.name,
    required this.image,
    required this.description,
    required this.budget,
    required this.days,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      budget: json['budget'],
      days: json['days'],
    );
  }
}
