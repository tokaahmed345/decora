import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/home/domain/entity/home_entity.dart';
import 'package:decora/feature/preview/preview_view.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item});
  final HomeEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                PreviewRoomDecoratorView(initialImage: item.image),
          ),
        );
      },
      child: Card(
        color: AppColors.lightBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      item.image,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          color: AppColors.greyColor.withOpacity(0.2),
                          child: const Icon(Icons.image_not_supported_outlined),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(item.category,
                      style: TextStyle(color: AppColors.greyColor)),
                  SizedBox(height: 6),
                  Text("Preview →", style: TextStyle(color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}