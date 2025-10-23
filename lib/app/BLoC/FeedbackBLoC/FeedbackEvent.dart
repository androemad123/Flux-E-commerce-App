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

  AddFeedback({
    required this.productID,
    required this.rating,
    required this.review,
  });
  @override
  List<Object?> get props => [productID,rating, review];
}

class DeleteFeedback extends FeedbackEvent {
  final String FeedbackID;
  DeleteFeedback({required this.FeedbackID});
  @override
  List<Object?> get props => [FeedbackID];
}

class UserEditFeedback extends FeedbackEvent {
  final String FeedbackID;
  final String ProductID;
  final int rating;
  final String review;

  UserEditFeedback({
    required this.FeedbackID,
    required this.ProductID,
    required this.rating,
    required this.review,
  });
  @override
  List<Object?> get props => [rating, review];
}

class LoadSpecificFeedback extends FeedbackEvent {
  final String field;
  final dynamic isEqualTo;
  LoadSpecificFeedback({required this.field, required this.isEqualTo});

  @override
  List<Object?> get props => [field, isEqualTo];
}
