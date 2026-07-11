part of 'room_analyzer_cubit.dart';

sealed class RoomAnalyzerState extends Equatable {
  const RoomAnalyzerState();

  @override
  List<Object> get props => [];
}



final class RoomAnalyzerInitial extends RoomAnalyzerState {}

final class RoomAnalyzerLoading extends RoomAnalyzerState {}

final class RoomAnalyzerSuccess extends RoomAnalyzerState {
  final RoomAnalysisEntity result;
  const RoomAnalyzerSuccess({required this.result});
  @override
  List<Object> get props => [result];
}

final class RoomAnalyzerFailure extends RoomAnalyzerState {
  final String errorMessage;
  const RoomAnalyzerFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}