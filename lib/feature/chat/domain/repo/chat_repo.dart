import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/chat/domain/entity/app_user_entity.dart';
import 'package:decora/feature/chat/domain/entity/chat_room_entity.dart';
import 'package:decora/feature/chat/domain/entity/messages_entity.dart';

abstract class ChatRepo {
   Stream<Either<Failure,List< MessagesEntity>>> getMessages({required String chatId});
 Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String senderId,
    String text = '',
    File? imageFile,
  }) ;
  Stream<Either<Failure, List<ChatRoomEntity>>> getUserChats({
    required String currentUserId,
  });
  Future<Either<Failure, String>> createChat({
  required String currentUserId,
  required String otherUserId,
}) ;
  Future<Either<Failure, List<SearchedUserEntity>>> searchUsers({
    required String query,
    required String currentUserId,
  });
 
  Future<Either<Failure, String?>> getExistingChatId({
    required String currentUserId,
    required String otherUserId,
  });
  Future<Either<Failure, void>> markChatAsRead({required String chatId, required String userId}); 
 
}
