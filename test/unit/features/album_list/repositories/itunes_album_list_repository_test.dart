import 'package:albums_sample/features/album_list/mappers/json_to_album_list_mapper.dart';
import 'package:albums_sample/features/album_list/models/album.dart';
import 'package:albums_sample/features/album_list/repositories/itunes_album_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockJsonToAlbumListMapper extends Mock implements JsonToAlbumListMapper {}

void main() {
  group('ItunesAlbumListDataSource', () {
    late ItunesAlbumListRepository repository;
    late MockJsonToAlbumListMapper mockMapper;
    late DioAdapter dioAdapter;

    setUp(() {
      Dio dio = Dio(
        BaseOptions(
          receiveTimeout: const Duration(seconds: 5),
          baseUrl: 'https://itunes.apple.com',
        ),
      );
      mockMapper = MockJsonToAlbumListMapper();
      dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      repository = ItunesAlbumListRepository(
        dioClient: dio,
        mapper: mockMapper,
      );
    });

    Map<String, dynamic> queryParameters({required int limit}) => {
          'id': 909253,
          'entity': 'album',
          'limit': limit,
        };

    test(
      'When response is successful Then return list of albums',
      () async {
        const limit = 10;
        const mockJson = 'mockJson';
        const mockAlbum = Album(name: '', imageUrl: '', currency: '');
        when(() => mockMapper.map(mockJson)).thenReturn([mockAlbum]);
        dioAdapter.onGet(
          '/lookup',
          (server) => server.reply(200, mockJson),
          queryParameters: queryParameters(limit: 10),
          data: mockJson,
        );

        final result = await repository.getAlbumList(limit);

        expect(result.length, equals(1));
        expect(result[0], equals(mockAlbum));
      },
    );

    test('When request fails Then throw DioException', () async {
      const limit = 10;

      dioAdapter.onGet(
        '/lookup',
        (server) => server.throws(
          500,
          DioException(requestOptions: RequestOptions()),
        ),
      );

      verifyNever(() => mockMapper.map(any()));

      expect(
        () async => await repository.getAlbumList(limit),
        throwsA(isA<DioException>()),
      );
    });
  });
}
