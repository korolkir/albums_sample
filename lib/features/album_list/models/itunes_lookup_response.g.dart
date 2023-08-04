// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itunes_lookup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItunesLookupResponse _$ItunesLookupResponseFromJson(
        Map<String, dynamic> json) =>
    ItunesLookupResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) =>
              ItunesLookupResultDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItunesLookupResponseToJson(
        ItunesLookupResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
