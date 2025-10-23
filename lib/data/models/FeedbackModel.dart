class Feedback {
  String FeedbackID;
  String ProductID;
  String UserID;
  int rating;
  String review;

  Feedback({
    required this.FeedbackID,
    required this.ProductID,
    required this.UserID,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> tojson() {
    return {
      'ProductID': ProductID,
      'UserID': UserID,
      'rating': rating,
      'review': review,
    };
  }

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      FeedbackID: json['FeedbackID']??  "No Feedback ID",
      ProductID: json['ProductID'] ?? "No Product ID",
      UserID: json['UserID'] ?? 'No User Name',
      rating: json['rating'] ?? 0,
      review: json['review'] ?? "No Review",
    );
  }
  // Helpful for updating fields without rebuilding everything
  Feedback copyWith({
    String? feedbackID,
    String? productID,
    String? userID,
    int? rating,
    String? review,
  }) {
    return Feedback(
      FeedbackID: feedbackID ?? this.FeedbackID,
      ProductID: productID ?? this.ProductID,
      UserID: userID ?? this.UserID,
      rating: rating ?? this.rating,
      review: review ?? this.review,
    );
  }
}
