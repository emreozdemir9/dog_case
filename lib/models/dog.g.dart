// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DogModel _$DogModelFromJson(Map<String, dynamic> json) => DogModel(
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      subBreeds: (json['subBreeds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DogModelToJson(DogModel instance) => <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'subBreeds': instance.subBreeds,
    };
