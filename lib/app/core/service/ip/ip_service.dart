import 'package:r_get_ip/r_get_ip.dart';

class IPService {
  Future<String> get ip async {
    var ipAddress = await RGetIp.internalIP;
    ipAddress ??= "0.0.0.0";
    return ipAddress;
  }
}
