import 'package:equatable/equatable.dart';

class DetailState extends Equatable {
  const DetailState({this.isLoading = false, this.randDogImage});

  final bool isLoading;
  final String? randDogImage;

  @override
  List<Object?> get props => [isLoading, randDogImage];

  DetailState copyWith({bool? isLoading, String? randDogImage}) {
    return DetailState(
        isLoading: isLoading ?? this.isLoading,
        randDogImage: randDogImage ?? this.randDogImage);
  }
}
