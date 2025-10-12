import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class product_color_size extends StatefulWidget {
  int currentImage;
  List<bool> currentColor;
  List<bool> CurrentSize;

  int selectedColor;
  int selectedSize;
  List<Color> clrs;
  List<String> txt;
  product_color_size(
      {super.key,
      required this.currentImage,
      required this.currentColor,
      required this.CurrentSize,
      required this.selectedColor,
      required this.selectedSize,
      required this.clrs,
      required this.txt});

  @override
  State<product_color_size> createState() => _product_color_sizeState();
}

class _product_color_sizeState extends State<product_color_size> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //product colors
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Color",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.fontFamily),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: List.generate(3, (index) {
                return IconButton.filled(
                  onPressed: () {
                    setState(() {
                      if (widget.currentColor[index] == false) {
                        for (int i = 0; i < widget.currentColor.length; i++) {
                          widget.currentColor[i] = false;
                        }
                        widget.currentColor[index] = true;
                        widget.selectedColor = index;
                        widget.currentImage = 0;
                      }
                    });
                  },
                  iconSize: widget.currentColor[index] ? 40 : 35,
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(),
                  icon: Icon(
                    Icons.circle,
                  ),
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          widget.currentColor[index]
                              ? Theme.of(context).colorScheme.shadow
                              : Theme.of(context).scaffoldBackgroundColor)),
                  color: widget.clrs[index],
                );
              }),
            ),
          ],
        ),
        Spacer(),
        // product sizes
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Size",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.fontFamily),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: List.generate(3, (index) {
                return CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (widget.CurrentSize[index] == false) {
                          for (int i = 0; i < widget.CurrentSize.length; i++) {
                            widget.CurrentSize[i] = false;
                          }
                          widget.CurrentSize[index] = true;
                          widget.selectedSize = index;
                          widget.currentImage = 0;
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: widget.CurrentSize[index]
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.transparent,
                      foregroundColor: Colors.transparent,
                    ),
                    child: Text(
                      widget.txt[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.CurrentSize[index]
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
