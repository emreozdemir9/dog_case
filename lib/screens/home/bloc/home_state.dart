import 'package:dogs_case/models/dog.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.isLoadingLoad, this.isLoadingData = false, this.dogList, this.searchText});

  final bool? isLoadingLoad;
  final bool isLoadingData;
  final List<DogModel>? dogList;
  final String? searchText;

  @override
  List<Object?> get props =>
      [isLoadingLoad, isLoadingData, dogList, searchText];

  HomeState copyWith(
      {bool? isLoadingLoad,
      bool? isLoadingData,
      List<DogModel>? dogList,
      String? searchText}) {
    return HomeState(
        isLoadingLoad: isLoadingLoad ?? this.isLoadingLoad,
        isLoadingData: isLoadingData ?? this.isLoadingData,
        dogList: dogList ?? this.dogList,
        searchText: searchText ?? this.searchText);
  }
}
