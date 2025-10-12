import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class starsRating extends StatefulWidget {
  int rate;
  int numOfRatings;
  starsRating({super.key, required this.rate, required this.numOfRatings});

  @override
  State<starsRating> createState() => _starsRatingState();
}

class _starsRatingState extends State<starsRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              onPressed: () {
                setState(() {
                  widget.rate = index + 1;
                });
              },
              icon: Icon(index < widget.rate ? Icons.star : Icons.star_border),
              color: index < widget.rate
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
            );
          }),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "(${widget.numOfRatings})",
          style: TextStyle(
              fontSize: 12,
              fontFamily: FontConstants.fontFamily,
              color: Theme.of(context).primaryColor),
        )
      ],
    );
  }
}
