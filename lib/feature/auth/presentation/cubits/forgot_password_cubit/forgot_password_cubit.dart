import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/data/repo_impl/forgot_password_repo_impl.dart';
import 'package:decora/feature/auth/domain/entity/forgot_password_entity.dart';
import 'package:decora/feature/auth/domain/usecase/forgot_password_use_case.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
    resetPassword({ required String email, })async{
    emit(ForgotPasswordLoading());
 final result=  await ForgotPasswordUseCase(repo: getIt.get<ForgotPasswordRepoImpl>()).call( email: email,);
 result.fold((fail) => emit(ForgotPasswordFailure(errorMessage: fail.message)),  (user) => emit(ForgotPasswordSuccess( forgot: user)));

  }


}
