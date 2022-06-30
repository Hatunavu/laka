import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/core/translations/translation_services.dart';
import 'package:client_tggt/router/app_screen.dart';
import 'package:client_tggt/screen/main/main_binding.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'router/router.gr.dart';
import 'package:bot_toast/bot_toast.dart';

final _appRouter = AppRouter();
final _botToastBuilder = BotToastInit();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void onAppInit() {
    AppLog();
    MainBinding().dependencies();
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, _) => GetMaterialApp.router(
              routerDelegate: AutoRouterDelegate(
                _appRouter,
                navigatorObservers: () => [
                  AutoRouteObserver(),
                ],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              // initialBinding: InitialBinding(router: _appRouter,),
              getPages: AppScreen.list,
              key: key,
              title: "Flutter project",
              onInit: onAppInit,
              theme: lightThemeData(context),
              darkTheme: darkThemeData(context),
              themeMode: ThemeServices().theme,
              locale: LocalizationService.locale,
              fallbackLocale: LocalizationService.fallbackLocale,
              translations: LocalizationService(),
              initialBinding: InitialBinding(
                router: _appRouter,
              ),
              builder: EasyLoading.init(builder: _botToastBuilder),
            ));
  }
}

class InitialBinding extends Bindings {
  AppRouter router;
  InitialBinding({
    required this.router,
  });
  @override
  void dependencies() {
    Get.put(
        RouterController(
          router: router,
        ),
        permanent: true);
  }
}

class RouterController extends GetxController {
  AppRouter router;

  RouterController({
    required this.router,
  });

  void toNamed(String route) {
    router.pushNamed(route);
  }

  void replace(PageRouteInfo<dynamic> page) {
    router.replace(page);
  }

  void push(PageRouteInfo<dynamic> page) {
    router.push(page);
  }

  void popUtilRoot() {
    router.popUntilRoot();
  }

  void back() {
    router.pop();
  }
}
