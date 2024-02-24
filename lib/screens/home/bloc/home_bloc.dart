import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs_case/models/dog.dart';
import 'package:dogs_case/screens/home/bloc/home_event.dart';
import 'package:dogs_case/screens/home/bloc/home_state.dart';
import 'package:dogs_case/server/app_endpoints.dart';
import 'package:dogs_case/server/dio_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuildContext context;
  HomeBloc(this.context) : super(const HomeState()) {
    on<LoadHomeEvent>((event, emit) async {
      await getAllDogsWithImage(emit, context, event.homeButtonClick);
    });
    on<SearchEvent>((event, emit) async {
      await searchDog(emit, context, event.searchText);
    });
  }

  Future<void> searchDog(
      Emitter<HomeState> emit, context, String searchText) async {
    emit(state.copyWith(searchText: searchText, isLoadingData: true));
    List<DogModel> dogList = [];
    await DioOperations.getRequest(
            AppEndPoints.randomFiveImageBySearchBreed(searchText))
        .then((res) async {
      if (res != null && res["message"].isNotEmpty) {
        for (var item in res["message"]) {
          dogList.add(DogModel(name: searchText, imageUrl: item));
        }
      }
    });
    emit(state.copyWith(dogList: dogList, isLoadingData: false));
  }

  Future<void> getAllDogsWithImage(
      Emitter<HomeState> emit, context, bool isHome) async {
    if (state.isLoadingData) return;
    emit(state.copyWith(isLoadingLoad: !isHome, isLoadingData: true,));
    Map<String, dynamic> res =
        await DioOperations.getRequest(AppEndPoints.allBreeds);
    List<DogModel> dogList = [];
    res["message"].map((key, value) {
      dogList.add(DogModel(name: key, subBreeds: value.cast<String>()));
      return MapEntry(key, value);
    });
    if (dogList.isNotEmpty) {
      await getDogRandImageByBreeds(emit, dogList, context, isHome);
    }
  }

  Future<void> getDogRandImageByBreeds(Emitter<HomeState> emit,
      List<DogModel> dogList, context, bool isHome) async {
    await Future.wait(dogList.map((e) => DioOperations.getRequest(
        AppEndPoints.randomImageByBreed(e.name ?? '')))).then((value) async {
      for (int i = 0; i <= value.length - 1; i++) {
        dogList[i].imageUrl = value[i]["message"];
      }
    });
    // Cach Images
    await Future.wait(
        dogList.map((e) async => await cacheImages(context, e.imageUrl!)));

    emit(state.copyWith(
      dogList: dogList,
      isLoadingLoad: false,
      isLoadingData: false,
      searchText: '',
    ));
  }

  Future<void> cacheImages(BuildContext context, String imageUrl) =>
      precacheImage(CachedNetworkImageProvider(imageUrl), context);
}
