
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:decora/feature/home/presentation/widgets/search_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key, required this.hint,
  });
final String hint ;
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child:  TextField(
            readOnly: true,
            onTap: (){
  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
            
                create: (_) => getIt.get<HomeCubit>()..homeData(),

            
              child: const SearchProducts(),
            ),
          )
  );
            },
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        );
  }
}