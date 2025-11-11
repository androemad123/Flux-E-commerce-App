import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class product_color_size extends StatefulWidget {
  final List<Color> clrs;
  final List<String> txt;
  const product_color_size(
      {super.key,
      required this.clrs,
      required this.txt});

  @override
  State<product_color_size> createState() => _product_color_sizeState();
}

class _product_color_sizeState extends State<product_color_size> {
  int currentImage = 0;
  late List<bool> currentColor;
  late List<bool> currentSize;
  int selectedColor = 0;
  int selectedSize = 0;
  
  @override
  void initState() {
    super.initState();
    currentColor = List.generate(widget.clrs.length, (index) => index == 0);
    currentSize = List.generate(widget.txt.length, (index) => index == 0);
  }
  
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
                      if (currentColor[index] == false) {
                        for (int i = 0; i < currentColor.length; i++) {
                          currentColor[i] = false;
                        }
                        currentColor[index] = true;
                        selectedColor = index;
                        currentImage = 0;
                      }
                    });
                  },
                  iconSize: currentColor[index] ? 40 : 35,
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(),
                  icon: Icon(
                    Icons.circle,
                  ),
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          currentColor[index]
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
                        if (currentSize[index] == false) {
                          for (int i = 0; i < currentSize.length; i++) {
                            currentSize[i] = false;
                          }
                          currentSize[index] = true;
                          selectedSize = index;
                          currentImage = 0;
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: currentSize[index]
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.transparent,
                      foregroundColor: Colors.transparent,
                    ),
                    child: Text(
                      widget.txt[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: currentSize[index]
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
