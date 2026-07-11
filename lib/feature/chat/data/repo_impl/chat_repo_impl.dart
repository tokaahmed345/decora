import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/chat/data/data_source/chat_remote_data_source.dart';
import 'package:decora/feature/chat/domain/entity/app_user_entity.dart';
import 'package:decora/feature/chat/domain/entity/chat_room_entity.dart';
import 'package:decora/feature/chat/domain/entity/messages_entity.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDataSourceImpl chatRemoteDataSource;

  ChatRepoImpl({required this.chatRemoteDataSource, });

  @override
  Stream<Either<Failure, List<MessagesEntity>>> getMessages({
    required String chatId,
  }) async* {
    try {
      yield* chatRemoteDataSource.getMessages(chatId).map(
        (messages) => Right<Failure, List<MessagesEntity>>(messages),
      );
    } catch (e) {
      yield Left(Failure( e.toString()));
    }
  }

  
  Stream<Either<Failure, List<ChatRoomEntity>>> getUserChats({
    required String currentUserId,
  }) 
   async* {
    try {
      yield* chatRemoteDataSource.getUserChats(currentUserId).map(
        (chats) => Right<Failure, List<ChatRoomEntity>>(chats),
      );
    } catch (e) {
      yield Left(Failure( e.toString()));
    } 
  }

@override
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String senderId,
    String text = '',
    File? imageFile,
  }) async {
    try {
      await chatRemoteDataSource.sendMessage(
        chatId: chatId,
        senderId: senderId,
        text: text,
        imageFile: imageFile,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
@override
Future<Either<Failure, String>> createChat({
  required String currentUserId,
  required String otherUserId,
}) async {
  try {
    final chatId = await chatRemoteDataSource.createChat(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
    );
    return Right(chatId);
  } catch (e) {
    return Left(Failure( e.toString()));

  }

}

  @override
  Future<Either<Failure, String?>> getExistingChatId({
    required String currentUserId,
    required String otherUserId,
  }) async {
    try {
      final chatId = await chatRemoteDataSource.getExistingChatId(
        currentUserId: currentUserId,
        otherUserId: otherUserId,
      );
      return Right(chatId);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
 
  @override
  Future<Either<Failure, List<SearchedUserEntity>>> searchUsers({
    required String query,
    required String currentUserId,
  }) async {
    try {
      final users = await chatRemoteDataSource.searchUsers(
        query: query,
        currentUserId: currentUserId,
      );
      return Right(users);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
  @override
Future<Either<Failure, void>> markChatAsRead({
  required String chatId,
  required String userId,
}) async {
  try {
    await chatRemoteDataSource.markChatAsRead(chatId: chatId, userId: userId);
    return const Right(null);
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}


}