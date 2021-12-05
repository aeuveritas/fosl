import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/service/service_module.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/ip/ip_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/server_input/server_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/page/page.dart';

class DashboardModule extends Module {
  @override
  List<Module> get imports => [
        CoreServiceModule(),
      ];

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<IPBloc>((i) => IPBloc()),
        Bind.singleton<ClientInputBloc>((i) => ClientInputBloc()),
        Bind.singleton<ServerInputBloc>((i) => ServerInputBloc()),
        Bind.singleton<ControllerBloc>((i) => ControllerBloc())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const DashboardPage(),
          transition: TransitionType.noTransition,
        )
      ];
}
