import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'itunes_lookup_result_data_model.dart';

part 'itunes_lookup_response.g.dart';

@JsonSerializable()
final class ItunesLookupResponse extends Equatable {
  final List<ItunesLookupResultDataModel>? results;

  const ItunesLookupResponse({this.results});

  @override
  List<Object?> get props => [results];

  factory ItunesLookupResponse.fromJson(Map<String, dynamic> json) =>
      _$ItunesLookupResponseFromJson(json);
}
