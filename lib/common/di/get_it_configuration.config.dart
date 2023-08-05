// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/album_list/blocs/album_list_bloc.dart' as _i9;
import '../../features/album_list/blocs/album_list_bloc_settings.dart' as _i3;
import '../../features/album_list/mappers/json_to_album_list_mapper.dart'
    as _i5;
import '../../features/album_list/mappers/json_to_album_list_mapper_impl.dart'
    as _i6;
import '../../features/album_list/repositories/album_list_repository.dart'
    as _i7;
import '../../features/album_list/repositories/itunes_album_list_repository.dart'
    as _i8;
import 'get_it_configuration.dart' as _i10;

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
  gh.factory<_i3.AlbumListBlocSettings>(
      () => registerModule.albumListBlocSettings);
  gh.factory<_i4.Dio>(() => registerModule.dioClient);
  gh.factory<_i5.JsonToAlbumListMapper>(() => _i6.JsonToAlbumListMapperImpl());
  gh.factory<_i7.AlbumListRepository>(() => _i8.ItunesAlbumListRepository(
        dioClient: gh<_i4.Dio>(),
        mapper: gh<_i5.JsonToAlbumListMapper>(),
      ));
  gh.factory<_i9.AlbumListBloc>(() => _i9.AlbumListBloc(
        albumsRepository: gh<_i7.AlbumListRepository>(),
        settings: gh<_i3.AlbumListBlocSettings>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i10.RegisterModule {}
