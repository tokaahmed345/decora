part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}
final class ForgotPasswordLoading extends ForgotPasswordState {}
final class ForgotPasswordSuccess extends ForgotPasswordState {
final ForgotPasswordEntity forgot;

  const ForgotPasswordSuccess({required this.forgot});

}
final class ForgotPasswordFailure extends ForgotPasswordState {
  final String errorMessage;

  const ForgotPasswordFailure({required this.errorMessage});
  
  @override
  List<Object> get props => [errorMessage];
}
