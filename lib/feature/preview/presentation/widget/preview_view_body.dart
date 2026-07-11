
import 'dart:io';
import 'dart:ui' as ui;

import 'package:decora/core/utils/constant/constant.dart';
import 'package:decora/feature/ai_analyzer/presentation/ai_room_analyzer_view.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:decora/feature/preview/presentation/widget/bottom_control.dart';
import 'package:decora/feature/preview/presentation/widget/draggable_art.dart';
import 'package:decora/feature/preview/presentation/widget/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class PreviewRoomDecoratorViewBody extends StatefulWidget {
  final String? initialImage;
    final VoidCallback? onBack;

  const PreviewRoomDecoratorViewBody({super.key, this.initialImage, this.onBack});

  @override
  State<PreviewRoomDecoratorViewBody> createState() =>
      _PreviewRoomDecoratorViewBodyState();
}

class _PreviewRoomDecoratorViewBodyState
    extends State<PreviewRoomDecoratorViewBody> {
  String ? _selectedImage = "";
  int _selectedColorIndex = 0;
  File? _backgroundImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage ?? "";
  }

  void _onCategorySelected(String category) {
    setState(() => _selectedImage = "");
    context.read<HomeCubit>().filterByCategory(category);
  }

  void _onImageSelected(String imageUrl) {
    setState(() => _selectedImage = imageUrl);
  }

  void _onColorSelected(int index) {
    setState(() => _selectedColorIndex = index);
  }

  void _onBackgroundImagePicked(File image) {
    setState(() => _backgroundImage = image);
  }

Future<File?> _captureWidget() async {
  try {
    final boundary = _draggableKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/room_snapshot.png');
    await file.writeAsBytes(bytes);
    return file;
  } catch (e) {
    return null;
  }
}


  void _onAnalyzeTap() async {
  final snapshotFile = await _captureWidget();

  if (snapshotFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Something went wrong, try again')),
    );
    return;
  }

  final selectedCategory = await Navigator.of(context).push<String>(
    MaterialPageRoute(
      builder: (_) => AiRoomAnalyzerView(roomImage: snapshotFile),
    ),
  );

  if (selectedCategory != null && mounted) {
    _onCategorySelected(selectedCategory);
  }
}
final GlobalKey _draggableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            BlocListener<HomeCubit, HomeCubitState>(
              listener: (context, state) {
                if (state is HomeCubitSuccess &&
                    _selectedImage!.isEmpty &&
                    state.items.isNotEmpty) {
                  setState(() => _selectedImage = state.items.first.image);
                }
              },
             
      child: RepaintBoundary(
  key: _draggableKey,
  child: DraggableArt(
    selectedImage: _selectedImage,
    selectedColor: AppConstant.colorOptions[_selectedColorIndex],
    backgroundImage: _backgroundImage,
  //    onRemove: () {
  //   setState(() {
  //     _selectedImage = null;
  //   });
  // },
  ),
),
            ),

            BottomControl(
              selectedImage: _selectedImage,
              selectedColorIndex: _selectedColorIndex,
              onCategorySelected: _onCategorySelected,
              onImageSelected: _onImageSelected,
              onColorSelected: _onColorSelected,
            ),

            TopBar(
              onImagePicked: _onBackgroundImagePicked, onAnalyzeTap: _onAnalyzeTap,
              onBack: widget.onBack,
            ),
          ],
        ),
      ),
    );
  }
}