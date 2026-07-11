import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:decora/feature/home/presentation/widgets/custom_scroll_category.dart';
import 'package:decora/feature/home/presentation/widgets/home_grid.dart';
import 'package:decora/feature/home/presentation/widgets/home_header_section.dart';
import 'package:decora/feature/home/presentation/widgets/preview_banner.dart';
import 'package:decora/feature/home/presentation/widgets/search_bar.dart';
import 'package:decora/feature/home/presentation/widgets/section_header.dart';
import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
    @override
   void initState() {
    super.initState();
    if (context.read<HomeCubit>().state is! HomeCubitSuccess) {
  context.read<HomeCubit>().homeData();
}
 
   context.read<ImageProfileCubit>().getSavedImage(getIt.get<FirebaseAuth>().currentUser!.uid);
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          sliver: SliverToBoxAdapter(
            child: HomeHeaderSection(),
          ),
        ),

        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
        ),

        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
            child: CustomSearchBar(hint:               "Search decor, colors, styles...",),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),

         SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
            child:CustomScrollCategory(
  onCategorySelected: (category) {
    context.read<HomeCubit>().filterByCategory(category);
  }
),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),

        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
            child: PreviewBanner(),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),

        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
            child: SectionHeader(title: "Trending Now"),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: HomeGridView(),
        ),
      ],
    );
  }
}


