part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpSuccess extends SignUpState {
 final SignUpEntity signUpEntity;

  const SignUpSuccess({required this.signUpEntity});

}
final class SignUpFailure extends SignUpState {

final String errorMessage;

  const SignUpFailure({required this.errorMessage});

}
