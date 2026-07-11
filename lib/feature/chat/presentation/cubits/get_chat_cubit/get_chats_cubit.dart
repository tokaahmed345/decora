import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/domain/entity/chat_room_entity.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';
import 'package:decora/feature/chat/domain/usecase/get_chat_user_case.dart';
import 'package:equatable/equatable.dart';

part 'get_chats_state.dart';


class GetChatsCubit extends Cubit<GetChatsState> {
  GetChatsCubit() : super(GetChatsInitial());

  StreamSubscription? _chatsSubscription;

  void getChats({required String currentUserId}) {
    emit(GetChatsLoading());

    _chatsSubscription?.cancel();

    _chatsSubscription = GetUserChatsUsecase(
      repo: getIt.get<ChatRepo>(),
    ).call(currentUserId).listen(
      (result) {
        result.fold(
          (fail) => emit(GetChatsFailure(errorMessage: fail.message)),
          (chats) => emit(GetChatsSuccess(chats: chats)),
        );
      },
      onError: (error) {
        emit(GetChatsFailure(errorMessage: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}