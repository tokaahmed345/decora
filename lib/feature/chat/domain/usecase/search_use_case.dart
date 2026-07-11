import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/chat/domain/entity/app_user_entity.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';

class SearchUsersUsecase {
  final ChatRepo repo;

  SearchUsersUsecase({required this.repo});

  Future<Either<Failure, List<SearchedUserEntity>>> call({
    required String query,
    required String currentUserId,
  }) {
    return repo.searchUsers(query: query, currentUserId: currentUserId);
  }
}