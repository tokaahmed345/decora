
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/constant/constant.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomControl extends StatefulWidget {
  final String? selectedImage;
  final int selectedColorIndex;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onImageSelected;
  final ValueChanged<int> onColorSelected;

  const BottomControl({
    super.key,
    required this.selectedImage,
    required this.selectedColorIndex,
    required this.onCategorySelected,
    required this.onImageSelected,
    required this.onColorSelected,
  });

  @override
  State<BottomControl> createState() => _BottomControlState();
}

class _BottomControlState extends State<BottomControl> {
  int _selectedCategory = 0;

  final List<Map<String, dynamic>> _categories = [
        {'icon': Icons.all_inbox_outlined, 'label': 'All'},

    {'icon': Icons.brush_outlined, 'label': 'Wall Art'},
    {'icon': Icons.crop_square_outlined, 'label': 'Mirrors'},
    {'icon': Icons.shelves, 'label': 'Shelves'},
    {'icon': Icons.curtains_outlined, 'label': 'Curtains'},
    {'icon': Icons.format_paint_outlined, 'label': 'Paint'},
  ];


  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category tabs
            SizedBox(
              height: 64,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, i) {
                  final cat = _categories[i];
                  final isSelected = _selectedCategory == i;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: i == _categories.length - 1 ? 0 : 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedCategory = i);
                        widget.onCategorySelected(cat['label'] as String);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 70,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : const Color(0xFF2C2C2C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              cat['icon'] as IconData,
                              color: isSelected
                                  ? AppColors.lightBackground
                                  : Colors.grey[400],
                              size: 22,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cat['label'] as String,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.lightBackground
                                    : Colors.grey[400],
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: List.generate( AppConstant.colorOptions.length, (i) {
                final isSelected = widget.selectedColorIndex == i;
                return GestureDetector(
                  onTap: () => widget.onColorSelected(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.only(right: 8),
                    width: isSelected ? 32 : 28,
                    height: isSelected ? 32 : 28,
                    decoration: BoxDecoration(
                      color:  AppConstant.colorOptions[i],
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 2.5)
                          : null,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color:  AppConstant.colorOptions[i].withOpacity(0.5),
                                blurRadius: 6,
                                spreadRadius: 1,
                              )
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeCubitState>(
                    builder: (context, state) {
                      if (state is HomeCubitLoading) {
                        return SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, i) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        );
                      }

                      if (state is HomeCubitSuccess) {
                        final variants = state.items;
                        if (variants.isEmpty) return const SizedBox(height: 40);

                        return SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: variants.length,
                            itemBuilder: (context, i) {
                              final variant = variants[i];
                              final isSelected =
                                  widget.selectedImage == variant.image;
                              return GestureDetector(
                                onTap: () =>
                                    widget.onImageSelected(variant.image),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  margin: const EdgeInsets.only(right: 8),
                                  width: isSelected ? 40 : 36,
                                  height: isSelected ? 40 : 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: isSelected
                                        ? Border.all(
                                            color: Colors.white, width: 2)
                                        : null,
                                    image: DecorationImage(
                                      image: NetworkImage(variant.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      return const SizedBox(height: 40);
                    },
                  ),
                ),

                // Zoom controls
                // Row(
                //   children: [
                //     ZoomButton(icon: Icons.remove),
                //     const SizedBox(width: 8),
                //     ZoomButton(icon: Icons.add),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}