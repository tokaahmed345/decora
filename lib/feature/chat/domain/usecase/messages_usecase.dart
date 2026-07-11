
import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/chat/domain/entity/messages_entity.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';

class GetMessagesUsecase {
  final ChatRepo repo;

  GetMessagesUsecase({required this.repo});
  Stream<Either<Failure,List<MessagesEntity >>> call(String chatId){
return repo.getMessages (chatId:  chatId);
  }
    
}