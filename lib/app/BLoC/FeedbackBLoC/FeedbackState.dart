import 'package:depi_graduation/data/models/FeedbackModel.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  @override
  List<Object?> get props => [];
}

class initialState extends FeedbackState {
  final List<Feedback> Feedbacks;
  initialState({required this.Feedbacks});

  @override
  List<Object?> get props => [Feedbacks];
}

class FeedbackLoading extends FeedbackState {}

class AllFeedbacksLoaded extends FeedbackState {
  final List<Feedback?> Feedbacks;
  AllFeedbacksLoaded({required this.Feedbacks});

  @override
  List<Object?> get props => [Feedbacks];
}

class SpecificFeedbacks extends FeedbackState {
  final List<Feedback?> Feedbacks;
  SpecificFeedbacks({required this.Feedbacks});

  @override
  List<Object?> get props => [Feedbacks];
}

class FeedbackLoaded extends FeedbackState {
  final Feedback feedback;
  FeedbackLoaded({required this.feedback});

  @override
  List<Object?> get props => [Feedback];
}

class ErrorState extends FeedbackState {
  final String errorMSG;
  ErrorState({required this.errorMSG});

  @override
  List<Object?> get props => [errorMSG];
}

class FeedbackAdded extends FeedbackState{
  final String feedbackID;
  FeedbackAdded({required this.feedbackID});

  @override
  List<Object?> get props => [feedbackID];

}

class FeedbackUpdated extends FeedbackState{}

class FeedbackDeleted extends FeedbackState{}