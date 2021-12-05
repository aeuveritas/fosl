import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleep_sync/app/app.dart';
import 'package:sleep_sync/app/core/const/key.dart';
import 'package:sleep_sync/app/core/observer/global_bloc_observer.dart';

void main() async {
  await Hive.initFlutter();
  final _ = await Hive.openBox(HiveBox);

  const windowSize = Size(550, 800);
  await DesktopWindow.setWindowSize(windowSize);
  await DesktopWindow.setMinWindowSize(windowSize);
  await DesktopWindow.setMaxWindowSize(windowSize);

  BlocOverrides.runZoned(
    () => runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
    blocObserver: GlobalBlocObserver(),
  );
}
