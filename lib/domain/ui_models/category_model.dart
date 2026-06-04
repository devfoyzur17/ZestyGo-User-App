class CategoryModel {
  final String id;
  final String name;
  final String? imageUrl; // Optional field if you have category images

  CategoryModel({required this.id, required this.name, this.imageUrl});

  // Factory to convert Firestore DocumentSnapshot to CategoryModel object
  factory CategoryModel.fromFirestore(String id, Map<String, dynamic> data) {
    return CategoryModel(
      id: id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'],
    );
  }
}