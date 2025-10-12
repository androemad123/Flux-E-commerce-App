import 'package:flutter/material.dart';

class sliverAppbar extends StatelessWidget {
  final VoidCallback? onBack;
  final bool isFavourite;
  final VoidCallback? onFavouriteToggle;

  const sliverAppbar({
    super.key,
    this.onBack,
    required this.isFavourite,
    this.onFavouriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: IconButton(
        onPressed: onBack ??
            () {
              Navigator.pop(context);
            },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onFavouriteToggle,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
          icon: Icon(
            Icons.favorite_rounded,
            color: isFavourite
                ? Colors.red
                : Theme.of(context).colorScheme.surface,
            size: 20,
          ),
        ),
      ],
    );
  }
}
