import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_graduation/app/BLoC/FeedbackBLoC/FeedbackBLoC.dart';
import 'package:depi_graduation/app/BLoC/FeedbackBLoC/FeedbackEvent.dart';
import 'package:depi_graduation/app/BLoC/FeedbackBLoC/FeedbackState.dart';
import 'package:depi_graduation/data/models/FeedbackModel.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/drawIndicators.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_bloc/flutter_bloc.dart';

class Productreviews extends StatefulWidget {
  final String productId;

  const Productreviews({super.key, required this.productId});

  @override
  State<Productreviews> createState() => _ProductreviewsState();
}

class _ProductreviewsState extends State<Productreviews> {
  @override
  void initState() {
    super.initState();
    context.read<FeedbackBLoC>().add(
        LoadSpecificFeedback(field: 'ProductID', isEqualTo: widget.productId));
  }

  double _calculateAverageRating(List<Feedback> feedbacks) {
    if (feedbacks.isEmpty) return 0.0;
    final sum = feedbacks.fold<int>(
        0, (total, feedback) => total + feedback.rating);
    return sum / feedbacks.length;
  }

  List<double> _calculateRatingDistribution(List<Feedback> feedbacks) {
    final distribution = List<int>.filled(5, 0);
    for (final feedback in feedbacks) {
      if (feedback.rating >= 1 && feedback.rating <= 5) {
        distribution[feedback.rating - 1]++;
      }
    }
    final total = feedbacks.length;
    if (total == 0) return List.filled(5, 0.0);
    return distribution.map((count) => count / total).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBLoC, FeedbackState>(
      builder: (context, state) {
        List<Feedback> feedbacks = [];
        if (state is SpecificFeedbacks) {
          feedbacks = state.Feedbacks.whereType<Feedback>().toList();
        } else if (state is AllFeedbacksLoaded) {
          feedbacks = state.Feedbacks
              .whereType<Feedback>()
              .where((f) => f.ProductID == widget.productId)
              .toList();
        }

        final averageRating = _calculateAverageRating(feedbacks);
        final ratingDistribution = _calculateRatingDistribution(feedbacks);
        final numOfRatings = feedbacks.length;
        final numOfReviews = feedbacks.length;

        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          shape: Border.all(color: Colors.transparent),
          collapsedShape: Border.all(color: Colors.transparent),
          title: Text(
            "Reviews",
            style: TextStyle(
                fontFamily: FontConstants.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).primaryColor),
          ),
          children: [
            // the rating of the product
            Card(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Rating number
                        Text(
                          averageRating > 0
                              ? averageRating.toStringAsFixed(1)
                              : "0.0",
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: FontConstants.fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          " OUT OF 5",
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.surface,
                            fontFamily: FontConstants.fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        //Actual Rating of this product
                        Column(
                          children: [
                            //Actual Rating of this product
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Icon(
                                    i < averageRating.round()
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Theme.of(context).colorScheme.secondary,
                                    size: 20,
                                  ),
                              ],
                            ),
                            Text("$numOfRatings rating",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontFamily: FontConstants.fontFamily,
                                )),
                          ],
                        ),
                      ],
                    ),
                    // Indicators
                    for (int i = 0; i < 5; i++)
                      drawIndicators(
                          i: i,
                          nums: List.generate(5, (index) => 5 - index),
                          percentages: ratingDistribution.reversed.toList()),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "$numOfReviews Reviews",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontFamily: FontConstants.fontFamily,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // The Review of The Product
            if (feedbacks.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "No reviews yet. Be the first to review!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontFamily: FontConstants.fontFamily,
                  ),
                ),
              )
            else
              ...feedbacks.map((feedback) => _buildReviewCard(feedback)),
          ],
        );
      },
    );
  }

  Widget _buildReviewCard(Feedback feedback) {
    return FutureBuilder<String>(
      future: _getUserName(feedback.UserID),
      builder: (context, snapshot) {
        final userName = snapshot.data ?? 'User';
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: Icon(Icons.person,
                          color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: FontConstants.fontFamily,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeightManager.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                Icon(
                                  i < feedback.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 15,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  feedback.review,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: FontConstants.fontFamily,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> _getUserName(String userId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final doc = await firestore.collection('users').doc(userId).get();
      return doc.data()?['name'] as String? ?? 'User';
    } catch (e) {
      return 'User';
    }
  }
}
