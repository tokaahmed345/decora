import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';
import 'package:decora/feature/chat/domain/usecase/create_use_case.dart';
import 'package:equatable/equatable.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit() : super(CreateChatInitial());
   Future<void> createChat({
    required String currentUserId,
    required String otherUserId,
  }) async {
    emit(CreateChatLoading());

    final result = await CreateChatUsecase(
      repo: getIt.get<ChatRepo>(),
    ).call(currentUserId: currentUserId, otherUserId: otherUserId);

    result.fold(
      (failure) => emit(CreateChatFailure(errorMessage: failure.message)),
      (chatId) => emit(CreateChatSuccess(chatId: chatId)),
    );
  }
}
