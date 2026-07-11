import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {


  const ChatHeader({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          'Messages',
          style: AppStyle.text28.copyWith(color: AppColors.blackColor)
        ),
       
      ],
    );
  }
}
