import 'package:json_annotation/json_annotation.dart';
part 'dog.g.dart';

@JsonSerializable()
class DogModel {
  DogModel(
      {this.name,
      this.imageUrl,
      this.subBreeds,});
  String? name;
  String? imageUrl;
  List<String>? subBreeds;

  factory DogModel.fromJson(Map<String, dynamic> json) => _$DogModelFromJson(json);
  Map<String, dynamic> toJson() => _$DogModelToJson(this);
}
