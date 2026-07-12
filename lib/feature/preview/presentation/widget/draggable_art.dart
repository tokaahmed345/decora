
import 'dart:io';
import 'package:decora/core/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';

class DraggableArt extends StatefulWidget {
  final String? selectedImage;
  final Color selectedColor;
  final File? backgroundImage;
  // final VoidCallback? onRemove;

  const DraggableArt({
    super.key,
    this.selectedImage,
    required this.selectedColor,
    this.backgroundImage,
    // this.onRemove,
  });

  @override
  State<DraggableArt> createState() => _DraggableArtState();
}

class _DraggableArtState extends State<DraggableArt> {
  Offset _artPosition = const Offset(60, 80);
  double _scale = 1.0;
  double _lastScale = 1.0;

  final double baseSize = 80;

  late final double touchAreaSize = baseSize * 3.5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image + color filter.
        // Wrapped in RepaintBoundary so that dragging/scaling the art
        // (which triggers setState in this same widget tree) does NOT
        // force this expensive ColorFiltered background to repaint on
        // every gesture frame. This was the main source of the Raster jank.
        Positioned.fill(
          child: RepaintBoundary(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                widget.selectedColor.withOpacity(0.3),
                BlendMode.srcATop,
              ),
              child: widget.backgroundImage != null
                  ? Image.file(
                      widget.backgroundImage!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppAssets.homeLogo,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),

        if (widget.selectedImage != null && widget.selectedImage!.isNotEmpty)
          Positioned(
            left: _artPosition.dx,
            top: _artPosition.dy,
            child: GestureDetector(
              onScaleStart: (details) {
                _lastScale = _scale;
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scale = (_lastScale * details.scale).clamp(0.3, 3.0);
                  _artPosition += details.focalPointDelta;
                });
              },
              onScaleEnd: (_) {
                _lastScale = 1.0;
              },
              child: SizedBox(
                width: touchAreaSize,
                height: touchAreaSize,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
          
                    Center(
                      child: RepaintBoundary(
                        child: Transform.scale(
                          scale: _scale,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.selectedImage!,
                              width: baseSize,
                              height: baseSize,
                              fit: BoxFit.fill,
                    
                              cacheWidth: (baseSize * 2).toInt(),
                              cacheHeight: (baseSize * 2).toInt(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: (touchAreaSize / 2) + (baseSize * _scale / 2) - 14,
                    //   top: (touchAreaSize / 2) - (baseSize * _scale / 2) - 14,
                    //   // child: GestureDetector(
                    //   //   onTap: () {
                    //   //     // widget.onRemove?.call();
                    //   //   },
                    //   //   child: Container(
                    //   //     width: 28,
                    //   //     height: 28,
                    //   //     decoration: BoxDecoration(
                    //   //       color: Colors.white,
                    //   //       shape: BoxShape.circle,
                    //   //       boxShadow: [
                    //   //         BoxShadow(
                    //   //           color: Colors.black.withOpacity(0.2),
                    //   //           blurRadius: 4,
                    //   //         ),
                    //   //       ],
                    //   //     ),
                    //   //     // child: const Icon(
                    //   //     //   Icons.close,
                    //   //     //   size: 18,
                    //   //     //   color: Colors.black87,
                    //   //     // ),
                    //   //   ),
                    //   // ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}