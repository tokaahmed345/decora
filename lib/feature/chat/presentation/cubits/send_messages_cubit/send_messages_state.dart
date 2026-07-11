part of 'send_messages_cubit.dart';

sealed class SendMessagesState extends Equatable {
  const SendMessagesState();

  @override
  List<Object> get props => [];
}

final class SendMessagesInitial extends SendMessagesState {}

final class SendMessagesLoading extends SendMessagesState {}
final class SendMessagesSuccess extends SendMessagesState {}
class SendMessagesFailure extends SendMessagesState {
  final String message;
  const SendMessagesFailure(this.message);
}