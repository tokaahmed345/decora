import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';
import 'package:decora/feature/chat/domain/usecase/send_messages_use_case.dart';
import 'package:equatable/equatable.dart';

part 'send_messages_state.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit() : super(SendMessagesInitial());

  void sendMessage({
    required String chatId,
    required String senderId,
    String text = '',
    File? imageFile,
  }) async {
    emit(SendMessagesLoading());

    final result = await SendMessagesUseCase(
      repo: getIt.get<ChatRepo>(),
    ).call(
      chatId: chatId,
      senderId: senderId,
      text: text,
      imageFile: imageFile,
    );

    result.fold(
      (failure) => emit(SendMessagesFailure(failure.message)),
      (_) => emit(SendMessagesSuccess()),
    );
  }
}