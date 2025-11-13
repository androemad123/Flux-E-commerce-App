import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class product_color_size extends StatefulWidget {
  final List<Color> clrs;
  final List<String> txt;
  final ValueChanged<int>? onColorChanged;
  final ValueChanged<int>? onSizeChanged;
  final int? selectedColorIndex;
  final int? selectedSizeIndex;

  const product_color_size({
    super.key,
    required this.clrs,
    required this.txt,
    this.onColorChanged,
    this.onSizeChanged,
    this.selectedColorIndex,
    this.selectedSizeIndex,
  });

  @override
  State<product_color_size> createState() => _product_color_sizeState();
}

class _product_color_sizeState extends State<product_color_size> {
  int? selectedColorIndex;
  int? selectedSizeIndex;

  @override
  void initState() {
    super.initState();
    selectedColorIndex =
        _normalizeIndex(widget.selectedColorIndex, widget.clrs.length);
    selectedSizeIndex =
        _normalizeIndex(widget.selectedSizeIndex, widget.txt.length);
  }

  @override
  void didUpdateWidget(covariant product_color_size oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clrs != oldWidget.clrs ||
        widget.selectedColorIndex != oldWidget.selectedColorIndex) {
      selectedColorIndex =
          _normalizeIndex(widget.selectedColorIndex, widget.clrs.length);
    }
    if (widget.txt != oldWidget.txt ||
        widget.selectedSizeIndex != oldWidget.selectedSizeIndex) {
      selectedSizeIndex =
          _normalizeIndex(widget.selectedSizeIndex, widget.txt.length);
    }
  }

  int? _normalizeIndex(int? index, int length) {
    if (length == 0) return null;
    if (index == null) return 0;
    if (index < 0) return 0;
    if (index >= length) return length - 1;
    return index;
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
              children: List.generate(widget.clrs.length, (index) {
                final isSelected = selectedColorIndex == index;
                return IconButton.filled(
                  onPressed: () {
                    setState(() {
                      selectedColorIndex = index;
                    });
                    widget.onColorChanged?.call(index);
                  },
                  iconSize: isSelected ? 40 : 35,
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(),
                  icon: Icon(
                    Icons.circle,
                  ),
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(isSelected
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
              children: List.generate(widget.txt.length, (index) {
                final isSelected = selectedSizeIndex == index;
                return CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedSizeIndex = index;
                      });
                      widget.onSizeChanged?.call(index);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: isSelected
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.transparent,
                      foregroundColor: Colors.transparent,
                    ),
                    child: Text(
                      widget.txt[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
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
