part of 'home_cubit_cubit.dart';

sealed class HomeCubitState extends Equatable {
  const HomeCubitState();

  @override
  List<Object> get props => [];
}

final class HomeCubitInitial extends HomeCubitState {}
final class HomeCubitLoading extends HomeCubitState {}
final class HomeCubitSuccess extends HomeCubitState {
   final List<HomeEntity> items;
  final List<HomeEntity> allItems;

  const HomeCubitSuccess({required this.items, required this.allItems});

  @override
  List<Object> get props => [items, allItems];


}
final class HomeCubitFailure extends HomeCubitState {final String errorMessage;

  const HomeCubitFailure({required this.errorMessage});
}
