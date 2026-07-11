part of 'get_messages_cubit.dart';

sealed class GetMessagesState extends Equatable {
  const GetMessagesState();

  @override
  List<Object> get props => [];
}

final class GetMessagesInitial extends GetMessagesState {}
final class GetMessagesLoading extends GetMessagesState {}
final class GetMessagesSuccess extends GetMessagesState {
   final List<MessagesEntity> messages;
  const GetMessagesSuccess({required this.messages});
  
  @override
  List<Object> get props => [messages];
}
final class GetMessagesFailure extends GetMessagesState {
  final String message;
  const GetMessagesFailure( {required this.message});
  
  @override
  List<Object> get props => [message];
}
