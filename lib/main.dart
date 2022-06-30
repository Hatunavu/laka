import 'package:client_tggt/app.dart';
import 'package:client_tggt/firebase_config.dart';
import 'package:client_tggt/firebase_options.dart';
import 'package:client_tggt/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDeepLink().fetchFirebaseDynamicLink();
  await GetStorage.init();
  configureDependencies();
  // FirebaseMessage().listenToMessage();
  initializeDateFormatting().then(
    (value) =>
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .then((_) {
      runApp(MyApp());
    }),
  );
}
