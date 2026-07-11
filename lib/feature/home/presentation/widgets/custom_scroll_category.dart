

import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomScrollCategory extends StatefulWidget {
  const CustomScrollCategory({
    super.key,
    this.onCategorySelected,
  });

  final void Function(String category)? onCategorySelected;

  @override
  State<CustomScrollCategory> createState() => _CustomScrollCategoryState();
}

class _CustomScrollCategoryState extends State<CustomScrollCategory> {
  static const List<String> items = [
    "All",
    "Wall Art",
    "Mirrors",
    "Shelves",
    "Curtains",
    "Paint",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected?.call(items[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.greyColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                items[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.lightBackground
                      : AppColors.blackColor,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: items.length,
      ),
    );
  }
}