import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';

class SendMessagesUseCase {
final ChatRepo repo;

  SendMessagesUseCase({required this.repo});

Future<Either<Failure, void>>call({
    required String chatId,
    required String senderId,
    required String text,
      File? imageFile,

  }) {
    return repo.sendMessage(
chatId:        chatId,
      senderId: senderId,
      text: text,
      imageFile: imageFile

    );
  }
}