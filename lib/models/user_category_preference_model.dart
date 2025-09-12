class UserCategoryPreference {
  final String userId;
  final String categoryId;
  final Category? category;

  UserCategoryPreference({
    required this.userId,
    required this.categoryId,
    this.category,
  });

  factory UserCategoryPreference.fromJson(Map<String, dynamic> json) {
    return UserCategoryPreference(
      userId: json['user_id'],
      categoryId: json['category_id'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'] ?? '',
    );
  }
}
