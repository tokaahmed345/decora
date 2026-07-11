import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/data/repo_impl/sign_up_repo_impl.dart';
import 'package:decora/feature/auth/domain/entity/signup_entity.dart';
import 'package:decora/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  createAccount({required String name, required String email, required String password})async{
    emit(SignUpLoading());
 final result=  await SignUpUseCase(repo: getIt.get<SignUpRepoImpl>()).call(name: name, email: email, password: password);
 result.fold((fail) => emit(SignUpFailure(errorMessage: fail.message)),  (user) => emit(SignUpSuccess( signUpEntity: user)));

  }




}
