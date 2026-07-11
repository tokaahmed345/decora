import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/data/repo_impl/chat_repo_impl.dart';
import 'package:decora/feature/chat/domain/entity/messages_entity.dart';
import 'package:decora/feature/chat/domain/usecase/messages_usecase.dart';
import 'package:equatable/equatable.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit() : super(GetMessagesInitial());
    StreamSubscription? _messagesSubscription;
 void getMessages({required String chatId})async{
      emit(GetMessagesLoading());

  _messagesSubscription  ?.cancel();
_messagesSubscription=GetMessagesUsecase(repo:        getIt.get<ChatRepoImpl>(),
).call(chatId).listen((result){
 result.fold(
          (fail) => emit(GetMessagesFailure(message:  fail.message)),
          (messages) => emit(GetMessagesSuccess(messages:  messages)),
        );
        

},
      onError: (e) => emit(GetMessagesFailure(message:  e.toString())),

);

 }   
  @override
  Future<void> close() {
   _messagesSubscription ?.cancel();
    return super.close();
  }
}
