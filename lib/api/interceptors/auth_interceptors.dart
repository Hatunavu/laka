import 'package:client_tggt/services/account_services.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  // Don't need stream subscription cause everytime we request, we get token
  // from cubit state and apply it to the request's header

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //  AppLog.info('---> ${request.method} ${request.url}');

    final userToken = AccountServices().getUserToken();
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['Authorization'] = 'Bearer $userToken';
    super.onRequest(options, handler);
  }

  // @override
  // Future<RequestOptions> onRequest(RequestOptions options) async {
  //   final authData = globals.authData;
  //
  //   if (authData?.accessToken != null) {
  //     options.headers['Authorization'] = 'Bearer ${authData.accessToken}';
  //   }
  //
  //   return options;
  // }
}
