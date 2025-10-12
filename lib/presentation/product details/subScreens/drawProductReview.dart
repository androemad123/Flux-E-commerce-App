import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class drawReview extends StatefulWidget {
  List<String> image;
  int i;
  drawReview({super.key, required this.image, required this.i});

  @override
  State<drawReview> createState() => _drawReviewState();
}

class _drawReviewState extends State<drawReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // reviewer photo
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Image.asset('${widget.image[widget.i]}'),
              ),
              //name of reviewer  and reviewer rated stars
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name of reviewer
                  Text(
                    "Jennifer Rose",
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: FontConstants.fontFamily,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeightManager.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  // reviewer rated stars
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Text(
                "5 min",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.shadow,
                  fontFamily: FontConstants.fontFamily,
                ),
              ),
            ],
          ),
          Text(
            "I love it."
            " Awesome customer service!! Helped me out "
            "with adding an"
            "additional item to my order."
            "Thanks again!",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: FontConstants.fontFamily,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
