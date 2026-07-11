import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/data/repo_impl/log_in_repo_impl.dart';
import 'package:decora/feature/auth/domain/entity/log_in_entity.dart';
import 'package:decora/feature/auth/domain/usecase/log_in_use_case.dart';
import 'package:equatable/equatable.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  
  logIn({ required String email, required String password})async{
    emit(LogInLoading());
 final result=  await LogInUseCase(repo: getIt.get<LogInRepoImpl>()).call( email: email, password: password);
 result.fold((fail) => emit(LogInFailure(errorMessage: fail.message)),  (user) => emit(LogInSuccess( logInEntity: user)));

  }
}
