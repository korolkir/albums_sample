import 'package:equatable/equatable.dart';

final class AlbumListBlocSettings extends Equatable {
  final int itemsAmountPerPage;
  const AlbumListBlocSettings({required this.itemsAmountPerPage});

  @override
  List<Object?> get props => [itemsAmountPerPage];
}
