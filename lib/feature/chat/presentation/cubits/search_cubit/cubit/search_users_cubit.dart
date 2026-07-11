import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/domain/entity/app_user_entity.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';
import 'package:decora/feature/chat/domain/usecase/search_use_case.dart';
import 'package:equatable/equatable.dart';

part 'search_users_state.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit() : super(SearchUsersInitial());
   Future<void> search({
    required String query,
    required String currentUserId,
  }) async {
   
    if (query.trim().isEmpty) {
      emit(SearchUsersInitial());
      return;
    }
 
    emit(SearchUsersLoading());
 
    final result = await SearchUsersUsecase(
      repo: getIt.get<ChatRepo>(),
    ).call(query: query, currentUserId: currentUserId);
 
    result.fold(
      (failure) => emit(SearchUsersFailure(errorMessage: failure.message)),
      (users) => emit(SearchUsersSuccess(users: users)),
    );
  }
 
  void clear() {
    emit(SearchUsersInitial());
  }
}
