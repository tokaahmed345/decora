
import 'package:decora/core/utils/assets/app_assets.dart';
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/preview/preview_view.dart';
import 'package:flutter/material.dart';

class PreviewBanner extends StatelessWidget {
  const PreviewBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.of(context).push(
    
    MaterialPageRoute(
      builder: (context) =>  PreviewRoomDecoratorView(),
      
    )
  );
      },
      child: Container(
       height: 140,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20),
         gradient: const LinearGradient(
           colors: [AppColors.primary, AppColors.accentGold],
         ),
       ),
       child: Row(
         children: [
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:  [
                   Text(
                     "✨ TRY NOW",
                     style: TextStyle(color: AppColors.whiteColor70),
                   ),
                   SizedBox(height: 6),
                   Text(
                     "Preview in\nYour Room →",
                     style: TextStyle(
                       color: AppColors.lightBackground,
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ],
               ),
             ),
           ),
            Expanded(
              child: Stack(children:[
                 
                 Positioned.fill(
                  child:
                  
                   ClipRRect(
                    
                    borderRadius: BorderRadiusGeometry.only(topRight: Radius.circular(16),bottomRight:Radius.circular(16)),
                    child: Image.asset(AppAssets.homeLogo,width: 180,height:180,fit: BoxFit.cover,))
                    ),
                      Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: AppColors.primaryDark.withOpacity(.5),
            ),
          ),
                      )
                    ]
                 
                 ),
                 
            )
         ],
       ),
          ),
    );
  }
}