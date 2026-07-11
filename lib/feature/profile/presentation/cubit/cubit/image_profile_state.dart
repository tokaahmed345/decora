part of 'image_profile_cubit.dart';


sealed class ImageProfileState extends Equatable {
  const ImageProfileState();

  @override
  List<Object?> get props => [];
}

final class ImageProfileInitial extends ImageProfileState {}

final class ImageProfileLoading extends ImageProfileState {
    final String? name;
  final String? imageUrl;

  const ImageProfileLoading({this.name, this.imageUrl});

  @override
  List<Object?> get props => [name, imageUrl];
}

final class ImageProfileSuccess extends ImageProfileState {
  final String imageUrl;
    final String name;


  const ImageProfileSuccess({required this.imageUrl, required this.name});

  @override
  List<Object?> get props => [imageUrl,name];
}

final class ImageProfileFailure extends ImageProfileState {
  final String errorMessage;

  const ImageProfileFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}