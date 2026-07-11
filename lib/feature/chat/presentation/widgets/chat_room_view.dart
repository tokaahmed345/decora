// import 'package:decora/core/utils/service_locator/service_locator.dart';
// import 'package:decora/feature/chat/presentation/cubits/get_messages_cubit/get_messages_cubit.dart';
// import 'package:decora/feature/chat/presentation/cubits/send_messages_cubit/send_messages_cubit.dart';
// import 'package:decora/feature/chat/presentation/widgets/chat_room_view_body.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChatRoomView extends StatelessWidget {
//   final String userName;
//   final String? userAvatar;
//   final String chatId;
//   final String currentUserId;
//   const ChatRoomView({
//     super.key,
//     required this.userName,
//     this.userAvatar,
//     required this.chatId,
//     required this.currentUserId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => getIt.get<GetMessagesCubit>()),
//         BlocProvider(create: (context) => getIt.get<SendMessagesCubit> ()),
//       ],
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F5F5),
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0.5,
//           titleSpacing: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, size: 20),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: Row(
//             children: [
//               CircleAvatar(
//                 radius: 18,
//                 backgroundColor: const Color(0xFFE3F2FD),
//                 backgroundImage: userAvatar != null
//                     ? NetworkImage(userAvatar!)
//                     : null,
//                 child: userAvatar == null
//                     ? Text(
//                         userName.isNotEmpty ? userName[0].toUpperCase() : '?',
//                         style: const TextStyle(
//                           color: Color(0xFF1565C0),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       )
//                     : null,
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     userName,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         body: ChatRoomViewBody(chatId: chatId, currentUserId: currentUserId),
//       ),
//     );
//   }
// }

import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/presentation/cubits/get_messages_cubit/get_messages_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/send_messages_cubit/send_messages_cubit.dart';
import 'package:decora/feature/chat/presentation/widgets/chat_room_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomView extends StatelessWidget {
  final String userName;
  final String? userAvatar;
  final String chatId;
  final String currentUserId;

  const ChatRoomView({
    super.key,
    required this.userName,
    this.userAvatar,
    required this.chatId,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt.get<GetMessagesCubit>()),
        BlocProvider(create: (_) => getIt.get<SendMessagesCubit>()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFE3F2FD),
                backgroundImage:
                    userAvatar != null ? NetworkImage(userAvatar!) : null,
                child: userAvatar == null
                    ? Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        body: ChatRoomViewBody(
          chatId: chatId,
          currentUserId: currentUserId,
          userName: userName,       
          userAvatar: userAvatar,   
        ),
      ),
    );
  }
}