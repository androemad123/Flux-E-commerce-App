import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllFeedbacks extends FeedbackEvent {}

class LoadFeedback extends FeedbackEvent {
  final String FeedbackID;
  LoadFeedback({required this.FeedbackID});
  @override
  List<Object?> get props => [FeedbackID];
}

class AddFeedback extends FeedbackEvent {
  final String productID;
  final int rating;
  final String review;
  final String? orderId;

  AddFeedback({
    required this.productID,
    required this.rating,
    required this.review,
    this.orderId,
  });
  @override
  List<Object?> get props => [productID, rating, review, orderId];
}

class DeleteFeedback extends FeedbackEvent {
  final String docID;
  DeleteFeedback({required this.docID});
  @override
  List<Object?> get props => [docID];
}

class UserEditFeedback extends FeedbackEvent {
  final String docID;
  final String ProductID;
  final int rating;
  final String review;

  UserEditFeedback({
    required this.docID,
    required this.ProductID,
    required this.rating,
    required this.review,
  });
  @override
  List<Object?> get props => [docID, ProductID, rating, review];
}

class LoadSpecificFeedback extends FeedbackEvent {
  final String field;
  final dynamic isEqualTo;
  LoadSpecificFeedback({required this.field, required this.isEqualTo});

  @override
  List<Object?> get props => [field, isEqualTo];
}
