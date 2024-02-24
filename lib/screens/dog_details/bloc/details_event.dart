
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable 
abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class RandImageEvent extends DetailEvent{
  const RandImageEvent(this.dogBreedName);
  final String dogBreedName;
  @override
  List<Object> get props => [dogBreedName];
}