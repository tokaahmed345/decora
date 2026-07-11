import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/presentation/cubits/get_chat_cubit/get_chats_cubit.dart';
import 'package:decora/feature/chat/presentation/widgets/chat_view_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<GetChatsCubit>()..getChats(currentUserId: getIt.get<FirebaseAuth>().currentUser!.uid)),

          ],
          child: ChatViewBody(),
        ),
      ),
    );
  }
}
