
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable 
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent{
  const LoadHomeEvent({this.homeButtonClick = false});
  final bool homeButtonClick;
  @override
  List<Object> get props => [homeButtonClick];
}

class SearchEvent extends HomeEvent{
  const SearchEvent(this.searchText);
  final String searchText;
  @override
  List<Object> get props => [searchText];
}