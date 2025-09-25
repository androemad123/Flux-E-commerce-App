import 'package:depi_graduation/cubit/auth/auth_cubit.dart';
import 'package:depi_graduation/data/auth/auth_data_source.dart';
import 'package:depi_graduation/firebase_services/firebase_auth_services.dart';
import 'package:get_it/get_it.dart';

class SetupSeviceLocator {
  static final sl = GetIt.asNewInstance();

  static void init() {
    registerCore();
    registerDataSources();
    registerCubits();
  }

  static void registerDataSources() {
    sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(authServices: sl<FirebaseAuthServices>()),
    );
  }

  static void registerCubits() {
    sl.registerLazySingleton<AuthCubit>(
        () => AuthCubit(authDataSource: sl<AuthDataSource>()));
  }

  static void registerCore() {
    sl.registerLazySingleton<FirebaseAuthServices>(
      () => FirebaseAuthServices(),
    );
  }
}
