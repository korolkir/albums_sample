import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_bloc_settings.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_state.dart';
import 'package:albums_sample/features/album_list/models/album.dart';
import 'package:albums_sample/features/album_list/repositories/album_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumListRepository extends Mock implements AlbumListRepository {}

void main() {
  group('AlbumListBloc', () {
    late AlbumListBloc bloc;
    late MockAlbumListRepository mockRepository;
    const itemsPerPage = 3;

    setUp(() {
      mockRepository = MockAlbumListRepository();
      bloc = AlbumListBloc(
        albumsRepository: mockRepository,
        settings: const AlbumListBlocSettings(itemsAmountPerPage: itemsPerPage),
      );
    });

    const incompleteAlbumList = [
      Album(name: 'name1', imageUrl: 'image1', currency: ''),
      Album(name: 'name2', imageUrl: 'image2', currency: ''),
    ];

    const completeAlbumList = [
      ...incompleteAlbumList,
      Album(name: 'name3', imageUrl: 'image3', currency: ''),
    ];

    blocTest<AlbumListBloc, AlbumListState>(
      'When LoadAlbumListEvent added and repository return incomplete list '
      'Then emit AlbumsLoaded with albums and canLoadMore is false',
      build: () => bloc,
      act: (bloc) {
        when(() => mockRepository.getAlbumList(itemsPerPage))
            .thenAnswer((_) async => incompleteAlbumList);
        bloc.add(const LoadAlbumListEvent());
      },
      expect: () => const [
        Loading(),
        AlbumsLoaded(albums: incompleteAlbumList, canLoadMore: false),
      ],
    );

    blocTest<AlbumListBloc, AlbumListState>(
      'When LoadAlbumListEvent added and repository return complete list '
      'Then emit AlbumsLoaded with albums and canLoadMore is true',
      build: () => bloc,
      act: (bloc) {
        when(() => mockRepository.getAlbumList(itemsPerPage))
            .thenAnswer((_) async => completeAlbumList);
        bloc.add(const LoadAlbumListEvent());
      },
      expect: () => const [
        Loading(),
        AlbumsLoaded(albums: completeAlbumList, canLoadMore: true)
      ],
    );

    blocTest<AlbumListBloc, AlbumListState>(
        'When LoadAlbumListEvent added for second time '
        'Then call repository with new limit',
        build: () => bloc,
        act: (bloc) {
          when(() => mockRepository.getAlbumList(itemsPerPage))
              .thenAnswer((_) async => completeAlbumList);
          when(() => mockRepository.getAlbumList(itemsPerPage * 2))
              .thenAnswer((_) async => completeAlbumList);
          bloc.add(const LoadAlbumListEvent());
          bloc.add(const LoadAlbumListEvent());
        },
        verify: (_) {
          verify(() => mockRepository.getAlbumList(itemsPerPage * 2)).called(1);
        });

    blocTest<AlbumListBloc, AlbumListState>(
      'When repository throw an error Then emit Error state',
      build: () => bloc,
      act: (bloc) {
        when(() => mockRepository.getAlbumList(any())).thenThrow(Exception());

        bloc.add(const LoadAlbumListEvent());
      },
      expect: () => const [Loading(), Error()],
    );
  });
}
