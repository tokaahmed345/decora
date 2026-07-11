part of 'get_chats_cubit.dart';

sealed class GetChatsState extends Equatable {
  const GetChatsState();

  @override
  List<Object> get props => [];
}

final class GetChatsInitial extends GetChatsState {}
final class GetChatsLoading extends GetChatsState {}
final class GetChatsSuccess extends GetChatsState {
  final List<ChatRoomEntity>chats;

  const GetChatsSuccess({required this.chats});
  @override
  List<Object> get props => [chats];
}
final class GetChatsFailure extends GetChatsState {
  final String errorMessage;

  const GetChatsFailure({required this.errorMessage});

}
