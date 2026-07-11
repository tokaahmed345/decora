
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/domain/entity/app_user_entity.dart';
import 'package:decora/feature/chat/presentation/cubits/create_cubit/create_chat_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/search_cubit/cubit/search_users_cubit.dart';
import 'package:decora/feature/chat/presentation/widgets/chat_room_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  final String currentUserId = getIt.get<FirebaseAuth>().currentUser!.uid;
  SearchedUserEntity? _selectedUser; 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _onUserTap(SearchedUserEntity user) {
    _selectedUser = user; 
    context.read<CreateChatCubit>().createChat(
          currentUserId: currentUserId,
          otherUserId: user.id,
        );
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
            hintText: 'Search by name...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            context.read<SearchUsersCubit>().search(
                  query: value,
                  currentUserId: currentUserId,
                );
          },
        ),
      ),
      body: BlocListener<CreateChatCubit, CreateChatState>(
        listener: (context, state) {
          if (state is CreateChatSuccess) {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => ChatRoomView(userName: _selectedUser!.name, chatId: state.chatId, currentUserId: currentUserId),
            ));
          } else if (state is CreateChatFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: BlocBuilder<SearchUsersCubit, SearchUsersState>(
          builder: (context, state) {
            if (state is SearchUsersLoading) {
              return const SizedBox()
;            }

            if (state is SearchUsersSuccess && state.users.isNotEmpty) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(user.name),
                    onTap: () => _onUserTap(user),
                  );
                },
              );
            }

            if (state is SearchUsersSuccess && state.users.isEmpty) {
              return const Center(child: Text('No users found'));
            }

            return const Center(child: Text('Search for someone...'));
          },
        ),
      ),
    );
  }
}