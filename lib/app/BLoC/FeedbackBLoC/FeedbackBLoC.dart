import 'package:depi_graduation/app/BLoC/FeedbackBLoC/FeedbackEvent.dart';
import 'package:depi_graduation/app/BLoC/FeedbackBLoC/FeedbackState.dart';
import 'package:depi_graduation/data/models/FeedbackModel.dart';
import 'package:depi_graduation/firebase_services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class FeedbackBLoC extends Bloc<FeedbackEvent, FeedbackState> {
  final firestore = FirestoreService<Feedback>(
      collection: "Feedbacks",
      fromJson: (json) => Feedback.fromJson(json),
      toJson: (Feedback) => Feedback.tojson());

  FeedbackBLoC() : super(initialState(Feedbacks: [])) {
    on<LoadAllFeedbacks>(
      (event, emit) async {
        emit(FeedbackLoading());
        List<Feedback?> Feedbacks = await firestore.getAll();
        if (Feedbacks.isEmpty) {
          emit(ErrorState(errorMSG: "Feedbacks Not Found"));
        } else {
          emit(AllFeedbacksLoaded(Feedbacks: Feedbacks));
        }
      },
    );

    on<LoadFeedback>(
      (event, emit) async {
        emit(FeedbackLoading());
        Feedback? feedback = await firestore.get(event.FeedbackID);
        if (feedback == null)
          emit(ErrorState(errorMSG: "Feedback Not Found"));
        else {
          emit(FeedbackLoaded(feedback: feedback));
        }
      },
    );

    on<LoadSpecificFeedback>(
      (event, emit) async {
        emit(FeedbackLoading());

        List<Feedback?> Feedbacks =
            await firestore.getWhere(event.field, event.isEqualTo);
        if (Feedbacks.isEmpty) {
          emit(ErrorState(errorMSG: "Feedbacks Not Found"));
        } else {
          emit(SpecificFeedbacks(Feedbacks: Feedbacks));
        }
      },
    );

    on<AddFeedback>(
      (event, emit) async {
        emit(FeedbackLoading());
        // final feedbackID = const Uuid().v4();
        final userID = FirebaseAuth.instance.currentUser!.uid;

        final feedback = Feedback(
            ProductID: event.productID,
            UserID: userID,
            rating: event.rating,
            review: event.review,
            orderId: event.orderId,
        );

        try {
          String docID = await firestore.create(feedback);
          emit(FeedbackAdded(docID: docID));
        } catch (e) {
          emit(ErrorState(errorMSG: "${e.toString()}"));
        }
      },
    );

    on<UserEditFeedback>(
      (event, emit) async {
        emit(FeedbackLoading());
        final userID = FirebaseAuth.instance.currentUser!.uid;
        Feedback? fdbk = await firestore.get(event.docID);
        if (fdbk!.UserID == userID) {
          final updatedFeedback = Feedback(
              //  FeedbackID: event.FeedbackID,
              ProductID: event.ProductID,
              UserID: userID,
              rating: event.rating,
              review: event.review);
          try {
            await firestore.update(event.docID, updatedFeedback);
            emit(FeedbackUpdated());
          } catch (e) {
            emit(ErrorState(errorMSG: e.toString()));
          }
        } else {
          emit(ErrorState(errorMSG: "$userID   -   ${fdbk.UserID}"));
        }
      },
    );

    on<DeleteFeedback>(
      (event, emit) async {
        emit(FeedbackLoading());
        try {
          await firestore.delete(event.docID);
          emit(FeedbackDeleted());
        } catch (e) {
          emit(ErrorState(errorMSG: e.toString()));
        }
      },
    );
  }
}
