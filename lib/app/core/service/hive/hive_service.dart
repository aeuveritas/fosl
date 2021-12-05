import 'package:hive/hive.dart';
import 'package:sleep_sync/app/core/const/key.dart';
import 'package:sleep_sync/app/feature/dashboard/dashboard.dart';

class HiveService {
  HiveService() {
    box = Hive.box(HiveBox);
  }

  late Box box;

  ModeStatus get mode {
    final modeInt = box.get(HiveBoxMode, defaultValue: 0);
    return ModeStatus.values[modeInt];
  }

  Future<void> setMode(ModeStatus mode) async {
    final modeInt = ModeStatus.values.indexWhere((element) => element == mode);
    await box.put(HiveBoxMode, modeInt);
  }

  String get hostAddress {
    final _hostAddress = box.get(HiveBoxHostAddress, defaultValue: "0.0.0.0");
    return _hostAddress;
  }

  Future<void> setHostAddress(String hostAddress) async {
    await box.put(HiveBoxHostAddress, hostAddress);
  }

  String get serverPort {
    final _port = box.get(HiveBoxServerPort, defaultValue: "30000");
    return _port;
  }

  Future<void> setServerPort(String port) async {
    await box.put(HiveBoxServerPort, port);
  }

  String get clientPort {
    final _port = box.get(HiveBoxClientPort, defaultValue: "30000");
    return _port;
  }

  Future<void> setClientPort(String port) async {
    await box.put(HiveBoxClientPort, port);
  }

  String get syncInterval {
    final _syncInterval = box.get(HiveBoxSyncInterval, defaultValue: "5");
    return _syncInterval;
  }

  Future<void> setSyncInterval(String syncInterval) async {
    await box.put(HiveBoxSyncInterval, syncInterval);
  }
}
