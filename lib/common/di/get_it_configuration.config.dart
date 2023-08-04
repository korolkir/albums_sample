// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/album_list/mappers/json_to_album_list_mapper.dart'
    as _i4;
import '../../features/album_list/mappers/json_to_album_list_mapper_impl.dart'
    as _i5;
import '../../features/album_list/repositories/album_list_repository.dart'
    as _i6;
import '../../features/album_list/repositories/itunes_album_list_repository.dart'
    as _i7;
import 'get_it_configuration.dart' as _i8;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.Dio>(() => registerModule.dioClient);
  gh.factory<_i4.JsonToAlbumListMapper>(() => _i5.JsonToAlbumListMapperImpl());
  gh.factory<_i6.AlbumListRepository>(() => _i7.ItunesAlbumListRepository(
        dioClient: gh<_i3.Dio>(),
        mapper: gh<_i4.JsonToAlbumListMapper>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i8.RegisterModule {}
