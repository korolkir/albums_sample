// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itunes_lookup_result_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItunesLookupResultDataModel _$ItunesLookupResultDataModelFromJson(
        Map<String, dynamic> json) =>
    ItunesLookupResultDataModel(
      wrapperType: json['wrapperType'] as String?,
      collectionName: json['collectionName'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
      collectionPrice: (json['collectionPrice'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      collectionType: json['collectionType'] as String?,
    );

Map<String, dynamic> _$ItunesLookupResultDataModelToJson(
        ItunesLookupResultDataModel instance) =>
    <String, dynamic>{
      'wrapperType': instance.wrapperType,
      'collectionType': instance.collectionType,
      'collectionName': instance.collectionName,
      'artworkUrl100': instance.artworkUrl100,
      'collectionPrice': instance.collectionPrice,
      'currency': instance.currency,
    };
