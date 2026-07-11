import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/chat/domain/entity/chat_room_entity.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';

class GetUserChatsUsecase {
  final ChatRepo repo;

  GetUserChatsUsecase({required this.repo});

  Stream<Either<Failure, List<ChatRoomEntity>>> call(String currentUserId) {
    return repo.getUserChats(currentUserId: currentUserId);
  }
}