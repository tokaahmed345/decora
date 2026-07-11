import 'package:decora/feature/home/domain/entity/home_entity.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:decora/feature/preview/preview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(onPressed: (){
          GoRouter.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search by Product...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            context.read<HomeCubit>().searchByTitle(value);
          },
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state) {
          if (state is HomeCubitLoading) {
            return const SizedBox();
          }

          if (state is HomeCubitFailure) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is HomeCubitSuccess) {
            if (state.items.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final HomeEntity product = state.items[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  title: Text(product.title),
                  subtitle: Text(product.category),
                  onTap: () {
    Navigator.of(context).push(
    
    MaterialPageRoute(
      builder: (context) =>  PreviewRoomDecoratorView(initialImage: product.image,),
      
    )
  );

                  },
                );
              },
            );
          }

          return const Center(child: Text('Search for a product...'));
        },
      ),
    );
  }
}