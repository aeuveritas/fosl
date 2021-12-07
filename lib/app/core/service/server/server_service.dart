import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class ServerService {
  late Isolate isolate;
  late ReceivePort receivePort;

  Future<void> start(String port) async {
    receivePort = ReceivePort();
    try {
      isolate = await Isolate.spawn(runServer, [receivePort.sendPort, port]);
    } catch (e) {
      print("Error: $e");
    }
  }

  void stop() {
    receivePort.close();
    isolate.kill();
  }

  static Future<void> runServer(List<Object> arguments) async {
    final String port = arguments[1] as String;

    final portInt = int.parse(port);

    final handler = const Pipeline().addHandler(_echoRequest);

    final host = InternetAddress.anyIPv4;
    final server = await shelf_io.serve(handler, host, portInt);
    server.autoCompress = true;

    print('Serving at http://${server.address.host}:${server.port}');
  }

  static Response _echoRequest(Request request) {
    print("request: ${request.url}");
    return Response.ok(null);
  }
}
