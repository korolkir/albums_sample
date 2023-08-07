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
  group(
    'AlbumListBloc Tests',
    () {
      late AlbumListBloc bloc;
      late MockAlbumListRepository mockRepository;
      const itemsPerPage = 3;
      const favoriteAlbumIndex = 5;

      setUp(() {
        mockRepository = MockAlbumListRepository();
        bloc = AlbumListBloc(
          albumsRepository: mockRepository,
          settings:
              const AlbumListBlocSettings(itemsAmountPerPage: itemsPerPage),
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
          AlbumListState(
            albums: incompleteAlbumList,
            canLoadMore: false,
            status: AlbumListStatus.success,
          )
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
          AlbumListState(
            albums: completeAlbumList,
            canLoadMore: true,
            status: AlbumListStatus.success,
          )
        ],
      );

      blocTest<AlbumListBloc, AlbumListState>(
        'When LoadAlbumListEvent added for second time and canLoadMore = true'
        'Then call repository with new limit',
        build: () => bloc..add(const LoadAlbumListEvent()),
        act: (bloc) {
          when(() => mockRepository.getAlbumList(itemsPerPage))
              .thenAnswer((_) async => completeAlbumList);
          when(() => mockRepository.getAlbumList(itemsPerPage * 2))
              .thenAnswer((_) async => completeAlbumList);
          bloc.add(const LoadAlbumListEvent());
        },
        verify: (_) {
          verify(() => mockRepository.getAlbumList(itemsPerPage * 2)).called(1);
        },
      );

      blocTest<AlbumListBloc, AlbumListState>(
        'When LoadAlbumListEvent added for second time but canLoadMore = false'
        'Then should not call the repository',
        build: () => bloc..add(const LoadAlbumListEvent()),
        act: (bloc) {
          when(() => mockRepository.getAlbumList(itemsPerPage))
              .thenAnswer((_) async => incompleteAlbumList);
          bloc.add(const LoadAlbumListEvent());
        },
        verify: (_) {
          verifyNever(() => mockRepository.getAlbumList(itemsPerPage * 2));
        },
      );

      blocTest<AlbumListBloc, AlbumListState>(
        'When repository throw an error '
        'Then emit state with error status',
        build: () => bloc,
        act: (bloc) {
          when(() => mockRepository.getAlbumList(any())).thenThrow(Exception());

          bloc.add(const LoadAlbumListEvent());
        },
        expect: () => const [
          AlbumListState(
            canLoadMore: true,
            status: AlbumListStatus.error,
          )
        ],
      );

      blocTest<AlbumListBloc, AlbumListState>(
        'When ToggleFavoriteAlbumEvent added && album is not favorite '
        'Then emit favorite albums set with added index',
        build: () => bloc,
        act: (bloc) {
          bloc.add(const ToggleFavoriteAlbumEvent(index: favoriteAlbumIndex));
        },
        expect: () => const [
          AlbumListState(favoriteAlbums: {favoriteAlbumIndex}),
        ],
      );

      blocTest<AlbumListBloc, AlbumListState>(
        'When ToggleFavoriteAlbumEvent added && album is already in favorite list '
        'Then emit favorite albums set without added index',
        build: () => bloc
          ..add(const ToggleFavoriteAlbumEvent(index: favoriteAlbumIndex)),
        act: (bloc) {
          bloc.add(const ToggleFavoriteAlbumEvent(index: favoriteAlbumIndex));
        },
        skip: 1,
        expect: () => const [
          AlbumListState(favoriteAlbums: {}),
        ],
      );
    },
  );
}
