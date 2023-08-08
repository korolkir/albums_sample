import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itunes_lookup_result_data_model.g.dart';

@JsonSerializable()
final class ItunesLookupResultDataModel extends Equatable {
  final String? wrapperType;
  final String? collectionType;
  final String? collectionName;
  final String? artworkUrl100;
  final double? collectionPrice;
  final String? currency;

  const ItunesLookupResultDataModel({
    this.wrapperType,
    this.collectionName,
    this.artworkUrl100,
    this.collectionPrice,
    this.currency,
    this.collectionType,
  });

  factory ItunesLookupResultDataModel.fromJson(Map<String, dynamic> json) =>
      _$ItunesLookupResultDataModelFromJson(json);

  @override
  List<Object?> get props => [
        wrapperType,
        collectionName,
        artworkUrl100,
        collectionPrice,
        currency,
        collectionType,
      ];
}
