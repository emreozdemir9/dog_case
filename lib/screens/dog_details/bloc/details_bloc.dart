import 'package:dogs_case/screens/dog_details/bloc/details_event.dart';
import 'package:dogs_case/screens/dog_details/bloc/details_state.dart';
import 'package:dogs_case/screens/dog_details/widgets/rand_dog_dialog.dart';
import 'package:dogs_case/server/app_endpoints.dart';
import 'package:dogs_case/server/dio_operations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBlock extends Bloc<DetailEvent, DetailState> {
  final BuildContext context;
  DetailBlock(this.context) : super(const DetailState()) {
    on<RandImageEvent>((event, emit) async {
      await getDogRandImage(emit, event.dogBreedName, context);
    });
  }

  Future<void> getDogRandImage(
      Emitter<DetailState> emit, String dogBreedName, context) async {
    emit(state.copyWith(isLoading: true));
    final res = await DioOperations.getRequest(
        AppEndPoints.randomImageByBreed(dogBreedName));
    showCupertinoModalPopup(
      context: context,
      barrierColor: Colors.black45,
      builder: (context) {
        return RandomImageDialog(res["message"]);
      },
    );
    emit(state.copyWith(randDogImage: res["message"], isLoading: false));
  }
}
