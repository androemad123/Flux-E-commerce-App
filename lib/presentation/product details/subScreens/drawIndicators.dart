import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class drawIndicators extends StatefulWidget {
  int i;
  List<int> nums;
  List<double> percentages;

  drawIndicators(
      {super.key,
      required this.i,
      required this.nums,
      required this.percentages});

  @override
  State<drawIndicators> createState() => _drawIndicatorsState();
}

class _drawIndicatorsState extends State<drawIndicators> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${widget.nums[widget.i]}",
          style: TextStyle(
              color: Theme.of(context).colorScheme.shadow,
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeightManager.bold,
              fontSize: 12),
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: Theme.of(context).colorScheme.secondary,
          size: 12,
        ),
        SizedBox(
          width: 3,
        ),
        Expanded(
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: widget.percentages[widget.i],
            minHeight: 3,
            backgroundColor: Theme.of(context).colorScheme.shadow,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        //Spacer(),
        Text("${widget.percentages[widget.i] * 100}%",
            style: TextStyle(
                color: Theme.of(context).colorScheme.shadow,
                fontFamily: FontConstants.fontFamily,
                fontSize: 12,
                fontWeight: FontWeightManager.bold)),
      ],
    );
  }
}
