import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/chat/presentation/cubits/create_cubit/create_chat_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/search_cubit/cubit/search_users_cubit.dart';
import 'package:decora/feature/chat/presentation/widgets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUsersWidget extends StatelessWidget {
  const SearchUsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => SearchUsersCubit()),
                BlocProvider(create: (_) => CreateChatCubit()),
              ],
              child: const SearchView(),
            ),
          ),
        );
      },
      child:Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child:  AbsorbPointer(
        child: TextField(
      
          decoration: const InputDecoration(
            hintText: 'Search conversations...',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none
          ),
        ),
      ) 
        )
      
      
    );
  }
}
