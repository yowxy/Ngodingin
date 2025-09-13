class Rating {
  final double average;
  final int count;

  Rating({required this.average, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: (json["average"] is int)
          ? (json['average'] as int).toDouble()
          : (json['average'] ?? 0.0).toDouble(),
      count: json["count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"average": average, "count": count};
  }
}
