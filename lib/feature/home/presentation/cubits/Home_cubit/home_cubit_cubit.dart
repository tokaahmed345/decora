import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/home/data/repo_impl/home_repo_impl.dart';
import 'package:decora/feature/home/domain/entity/home_entity.dart';
import 'package:decora/feature/home/domain/usecase/home_use_case.dart';
import 'package:equatable/equatable.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeCubitInitial());

  Future<void> homeData() async {
    emit(HomeCubitLoading());
    final result = await HomeUseCase(repo: getIt.get<HomeRepoImpl>()).call();
    result.fold(
      (fail) => emit(HomeCubitFailure(errorMessage: fail.message)),
      (items) => emit(HomeCubitSuccess(items: items, allItems: items)),
    );
  }

  void filterByCategory(String category) {
    final currentState = state;
    if (currentState is! HomeCubitSuccess) return;

    if (category == "All") {
      emit(
        HomeCubitSuccess(
          items: currentState.allItems,
          allItems: currentState.allItems,
        ),
      );
      return;
    }

    final filtered = currentState.allItems
        .where((item) => item.category == category)
        .toList();

    emit(HomeCubitSuccess(items: filtered, allItems: currentState.allItems));
  }

  void searchByTitle(String query) {
    final currentState = state;
    if (currentState is! HomeCubitSuccess) return;

    if (query.isEmpty) {
      emit(
        HomeCubitSuccess(
          items: currentState.allItems,
          allItems: currentState.allItems,
        ),
      );
      return;
    }

    final filtered = currentState.allItems
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(HomeCubitSuccess(items: filtered, allItems: currentState.allItems));
  }
}
