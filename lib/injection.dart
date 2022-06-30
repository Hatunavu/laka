import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/api/constant.dart';
import 'package:client_tggt/api/dio_di.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void configureDependencies() {
  getIt.registerLazySingleton<Dio>(() => _DioDi().dio);
  getIt.registerLazySingleton<IToast>(() => CustomBotToast());

  // Network
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(
        getIt.get<Dio>(),
        baseUrl: ApiConstants.baseUrl,
      ));
}

class _DioDi extends DioDi {}
