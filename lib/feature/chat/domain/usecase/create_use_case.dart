import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';

class CreateChatUsecase {
  final ChatRepo repo;

  CreateChatUsecase({required this.repo});

  Future<Either<Failure, String>> call({
    required String currentUserId,
    required String otherUserId,
  }) async {
    final existingResult = await repo.getExistingChatId(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
    );

    Failure? failure;
    String? existingChatId;

    existingResult.fold(
      (l) => failure = l,
      (r) => existingChatId = r,
    );

    if (failure != null) {
      return Left(failure!);
    }

    if (existingChatId != null) {
      return Right(existingChatId!);
    }

    return repo.createChat(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
    );
  }
}