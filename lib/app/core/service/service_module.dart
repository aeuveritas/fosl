import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/service/client/client_service.dart';
import 'package:sleep_sync/app/core/service/ip/ip_service.dart';
import 'package:sleep_sync/app/core/service/server/server_service.dart';

class CoreServiceModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<ServerService>(
          (i) => ServerService(),
          export: true,
        ),
        Bind.singleton<IPService>(
          (i) => IPService(),
          export: true,
        ),
        Bind.singleton<ClientService>(
          (i) => ClientService(),
          export: true,
        ),
      ];
}
