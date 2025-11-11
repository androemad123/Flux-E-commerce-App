import 'package:depi_graduation/presentation/product%20details/subScreens/drawIndicators.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/drawProductReview.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class Productreviews extends StatefulWidget {
  final int numOfRatings;
  final String ratingNumber;
  final int numOfReviews;
  final List<int> nums;
  final List<double> percentages;

  const Productreviews(
      {super.key,
      required this.numOfRatings,
      required this.ratingNumber,
      required this.numOfReviews,
      required this.nums,
      required this.percentages});

  @override
  State<Productreviews> createState() => _ProductreviewsState();
}

class _ProductreviewsState extends State<Productreviews> {
  final addReview = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      "${widget.ratingNumber}",
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
                                Icons.star,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 20,
                              ),
                          ],
                        ),
                        Text("${widget.numOfRatings} rating",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              // fontSize: 10,
                              fontFamily: FontConstants.fontFamily,
                            )),
                      ],
                    ),
                  ],
                ),
                // Indicators
                for (int i = 0; i < 5; i++)
                  drawIndicators(
                      i: i, nums: widget.nums, percentages: widget.percentages),
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
              "${widget.numOfReviews} Reviews",
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontFamily: FontConstants.fontFamily,
              ),
            ),
            Spacer(),
            Text("WRITE A REVIEW",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontFamily: FontConstants.fontFamily,
                )),
            SizedBox(
              width: 3,
            ),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: addReview,
                                  decoration: InputDecoration(
                                      label: Text(
                                        "Add Your Review",
                                        style: TextStyle(
                                            fontFamily:
                                                FontConstants.fontFamily,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  onPressed: () {},
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontFamily: FontConstants.fontFamily,
                                    ),
                                  ))
                            ],
                          ),
                        );
                      });
                },
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(),
                icon: Icon(
                  Icons.edit_outlined,
                  size: 25,
                  color: Theme.of(context).colorScheme.surface,
                ))
          ],
        ),
        SizedBox(
          height: 5,
        ),
        // The Review of The Product
        for (int i = 0; i < 2; i++)
          drawReview(image: [
            'assets/images/welcomePic.png',
            'assets/images/3rdOnboardingPic.jpg'
          ], i: i),
      ],
    );
  }
}
