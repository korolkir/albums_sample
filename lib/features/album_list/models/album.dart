import 'package:equatable/equatable.dart';

final class Album extends Equatable {
  final String name;
  final String imageUrl;
  final double? collectionPrice;
  final String currency;

  const Album({
    required this.name,
    required this.imageUrl,
    required this.currency,
    this.collectionPrice,
  });

  @override
  List<Object?> get props => [name, imageUrl, collectionPrice, currency];
}
