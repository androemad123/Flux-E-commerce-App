class Feedback {
  String? FeedbackID; //unique
  String ProductID;
  String UserID;
  int rating;
  String review;
  String? orderId;

  Feedback({
    this.FeedbackID,
    required this.ProductID,
    required this.UserID,
    required this.rating,
    required this.review,
    this.orderId,
  });

  Map<String, dynamic> tojson() {
    return {
      if (FeedbackID != null) 'FeedbackID': FeedbackID,
      'ProductID': ProductID,
      'UserID': UserID,
      'rating': rating,
      'review': review,
      if (orderId != null) 'orderId': orderId,
    };
  }

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      FeedbackID: json['FeedbackID'] ?? "",
      ProductID: json['ProductID'] ?? "No Product ID",
      UserID: json['UserID'] ?? 'No User Name',
      rating: json['rating'] ?? 0,
      review: json['review'] ?? "No Review",
      orderId: json['orderId'],
    );
  }
  // Helpful for updating fields without rebuilding everything
  Feedback copyWith({
    String? feedbackID,
    String? productID,
    String? userID,
    int? rating,
    String? review,
    String? orderId,
  }) {
    return Feedback(
      FeedbackID: feedbackID ?? this.FeedbackID,
      ProductID: productID ?? this.ProductID,
      UserID: userID ?? this.UserID,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      orderId: orderId ?? this.orderId,
    );
  }
}
