import 'package:flutter_test/flutter_test.dart';

import 'package:albums_sample/features/album_list/mappers/json_to_album_list_mapper_impl.dart';

import '../test_objects.dart';

void main() {
  group('JsonToAlbumListMapperImpl', () {
    late JsonToAlbumListMapperImpl mapper;

    setUp(() {
      mapper = JsonToAlbumListMapperImpl();
    });

    test(
      'When valid Json is provided Then mapper should return a list of albums',
      () {
        final albums = mapper.map(TestObjects.validJsonString);

        expect(albums, isNotEmpty);
        expect(albums.length, equals(3));

        expect(albums[0].name, equals('Album1'));
        expect(albums[0].imageUrl, equals('image1'));
        expect(albums[0].collectionPrice, equals(10.99));
        expect(albums[0].currency, equals('USD'));

        expect(albums[1].name, equals('Album2'));
        expect(albums[1].imageUrl, equals('image2'));
        expect(albums[1].collectionPrice, equals(12.99));
        expect(albums[1].currency, equals('USD'));

        expect(albums[2].name, isEmpty);
        expect(albums[2].imageUrl, isEmpty);
        expect(albums[2].collectionPrice, isNull);
        expect(albums[2].currency, isEmpty);
      },
    );

    test(
      'When invalid Json is provided Then mapper should return empty list',
      () {
        const jsonString = '{"hello": "world"}';

        final albums = mapper.map(jsonString);

        expect(albums, isEmpty);
      },
    );

    test(
      'When invalid formatted Json is provided Then mapper throw  format exception',
      () {
        expect(() => mapper.map('wdwd'), throwsFormatException);
      },
    );
  });
}
