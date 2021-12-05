import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/dashboard.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: DashboardModule(),
        ),
      ];
}
