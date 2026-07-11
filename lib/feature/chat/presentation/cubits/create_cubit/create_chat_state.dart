part of 'create_chat_cubit.dart';

sealed class CreateChatState extends Equatable {
  const CreateChatState();

  @override
  List<Object> get props => [];
}

final class CreateChatInitial extends CreateChatState {}
final class CreateChatLoading extends CreateChatState {}

final class CreateChatSuccess extends CreateChatState {
  final String chatId;
  const CreateChatSuccess({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

final class CreateChatFailure extends CreateChatState {
  final String errorMessage;
  const CreateChatFailure({required this.errorMessage});
}