part of 'search_users_cubit.dart';

sealed class SearchUsersState extends Equatable {
  const SearchUsersState();

  @override
  List<Object> get props => [];
}

final class SearchUsersInitial extends SearchUsersState {}
final class SearchUsersLoading extends SearchUsersState {}
 
final class SearchUsersSuccess extends SearchUsersState {
  final List<SearchedUserEntity> users;
 
  const SearchUsersSuccess({required this.users});
 
  @override
  List<Object> get props => [users];
}
 
final class SearchUsersFailure extends SearchUsersState {
  final String errorMessage;
 
  const SearchUsersFailure({required this.errorMessage});
 
  @override
  List<Object> get props => [errorMessage];
}