import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class starsRating extends StatefulWidget {
  final int rate;
  final int numOfRatings;
  const starsRating({super.key, required this.rate, required this.numOfRatings});

  @override
  State<starsRating> createState() => _starsRatingState();
}

class _starsRatingState extends State<starsRating> {
  late int currentRate;
  
  @override
  void initState() {
    super.initState();
    currentRate = widget.rate;
  }
  
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
                  currentRate = index + 1;
                });
              },
              icon: Icon(index < currentRate ? Icons.star : Icons.star_border),
              color: index < currentRate
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
