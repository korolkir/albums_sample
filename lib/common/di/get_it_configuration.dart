import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'get_it_configuration.config.dart';

final injector = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => init(injector);
