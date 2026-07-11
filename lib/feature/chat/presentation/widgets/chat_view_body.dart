
// import 'package:decora/core/utils/colors/app_colors.dart';
// import 'package:decora/core/utils/service_locator/service_locator.dart';
// import 'package:decora/feature/chat/presentation/cubits/get_chat_cubit/get_chats_cubit.dart';
// import 'package:decora/feature/chat/presentation/widgets/chat_header.dart';
// import 'package:decora/feature/chat/presentation/widgets/chat_list_item.dart';
// import 'package:decora/feature/chat/presentation/widgets/chat_room_view.dart';
// import 'package:decora/feature/chat/presentation/widgets/search_user_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChatViewBody extends StatefulWidget {
//   const ChatViewBody({super.key});

//   @override
//   State<ChatViewBody> createState() => _ChatViewBodyState();
// }

// class _ChatViewBodyState extends State<ChatViewBody> {


//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//         padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ChatHeader(),
//             const SizedBox(height: 16),
// SearchUsersWidget(),
//             const SizedBox(height: 8),

//             Expanded(
//               child: BlocBuilder<GetChatsCubit, GetChatsState>(
//                 builder: (context, state) {
//                   if (state is GetChatsLoading || state is GetChatsInitial) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (state is GetChatsFailure) {
//                     return Center(
//                       child: Text(
//                         state.errorMessage,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     );
//                   }

//                   if (state is GetChatsSuccess) {
//                     final chats = state.chats;

//                     if (chats.isEmpty) {
//                       return const Center(
//                         child: Text('No conversations yet'),
//                       );
//                     }

//                     return ListView.builder(
//                       padding: EdgeInsets.zero,
//                       itemCount: chats.length,
//                       itemBuilder: (context, index) {
//                         final chat = chats[index];
//                         return Column(
//                           children: [
//                             ChatListItem(
//                               avatarUrl: chat.otherUserAvatarUrl,
//                               name: chat.otherUserName,
//                               lastMessage: chat.lastMessage,
//                               time: _formatTime(chat.lastMessageTime),
//                               unreadCount: chat.unreadCount,
//                               onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (_) => ChatRoomView(userName: chat.otherUserName, chatId: chat.chatId, currentUserId:getIt.get<FirebaseAuth>().currentUser!.uid,),
//             ));
//                               },
//                             ),
//                             if (index != chats.length - 1)
//                               const Divider(
//                                 height: 1,
//                                 indent: 70,
//                                 color: AppColors.lightBackground,
//                               ),
//                           ],
//                         );
//                       },
//                     );
//                   }

//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
    
//   }

//   String _formatTime(DateTime? time) {
//     if (time == null) return '';

//     final now = DateTime.now();
//     final diff = now.difference(time);

//     if (diff.inMinutes < 1) return 'now';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m';
//     if (diff.inHours < 24) return '${diff.inHours}h';
//     if (diff.inDays == 1) return 'Yesterday';
//     return '${diff.inDays}d';
//   }
// }
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/presentation/cubits/get_chat_cubit/get_chats_cubit.dart';
import 'package:decora/feature/chat/presentation/widgets/chat_header.dart';
import 'package:decora/feature/chat/presentation/widgets/chat_list_item.dart';
import 'package:decora/feature/chat/presentation/widgets/chat_room_view.dart';
import 'package:decora/feature/chat/presentation/widgets/chat_shimmer.dart';
import 'package:decora/feature/chat/presentation/widgets/search_user_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChatHeader(),
          const SizedBox(height: 16),
          SearchUsersWidget(),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<GetChatsCubit, GetChatsState>(
              builder: (context, state) {
                if (state is GetChatsLoading || state is GetChatsInitial) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 6,
                    itemBuilder: (context, index) =>
                        const ChatListItemShimmer(),
                  );
                }

                if (state is GetChatsFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is GetChatsSuccess) {
                  final chats = state.chats;

                  if (chats.isEmpty) {
                    return const Center(
                      child: Text('No conversations yet'),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return Column(
                        children: [
                          ChatListItem(
                            avatarUrl: chat.otherUserAvatarUrl,
                            name: chat.otherUserName,
                            lastMessage: chat.lastMessage,
                            time: _formatTime(chat.lastMessageTime),
                            unreadCount: chat.unreadCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatRoomView(
                                    userName: chat.otherUserName,
                                    chatId: chat.chatId,
                                    currentUserId: getIt
                                        .get<FirebaseAuth>()
                                        .currentUser!
                                        .uid,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (index != chats.length - 1)
                            const Divider(
                              height: 1,
                              indent: 70,
                              color: AppColors.lightBackground,
                            ),
                        ],
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';

    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d';
  }
}