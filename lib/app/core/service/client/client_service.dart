import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:wakelock/wakelock.dart';

enum ClientServiceError {
  none,
  syncIntervalParseFailure,
  hostCommunicationFailure,
  unexpectedResponseFailure
}

class ClientService {
  late Isolate isolate;
  late ReceivePort receivePort;

  StreamController<bool>? _controller;

  Stream<bool> start(String hostIP, String port, String interval) async* {
    receivePort = ReceivePort();
    try {
      final targetURL = "http://$hostIP:$port";
      isolate = await Isolate.spawn(
          runClient, [receivePort.sendPort, targetURL, interval]);

      _controller ??= StreamController<bool>();
      receivePort.listen((result) {
        if (!_controller!.isClosed) {
          final error = result as ClientServiceError;
          String errorMessage = "";
          switch (error) {
            case ClientServiceError.syncIntervalParseFailure:
              errorMessage = "Failed to parse sync interval";
              break;
            case ClientServiceError.hostCommunicationFailure:
              errorMessage = "Failed to communicate with host($targetURL)";
              break;
            case ClientServiceError.unexpectedResponseFailure:
              errorMessage = "Unexpected response";
              break;
            default:
          }
          _controller!.addError(errorMessage);
        }
      });
    } catch (e) {
      print("Error: $e");
    }
    yield* _controller!.stream;
  }

  void stop() {
    if (_controller != null) {
      _controller!.close();
      _controller = null;
    }
    receivePort.close();
    isolate.kill();
    print("wakelock disable");
    Wakelock.disable();
  }

  static Future<void> runClient(List<Object> arguments) async {
    final SendPort sendPort = arguments[0] as SendPort;
    final String targetURL = arguments[1] as String;
    final String interval = arguments[2] as String;

    final intervalInt = int.tryParse(interval);
    if (intervalInt == null) {
      sendPort.send(ClientServiceError.syncIntervalParseFailure);
    }

    await requestAndResponse(sendPort, targetURL);

    Timer.periodic(Duration(minutes: intervalInt!), (timer) async {
      final ret = await requestAndResponse(sendPort, targetURL);
      if (ret == false) {
        timer.cancel();
      }
    });
  }

  static Future<bool> requestAndResponse(
    SendPort sendPort,
    String targetURL,
  ) async {
    final ret = await sendRequest(targetURL);
    if (ret != ClientServiceError.none) {
      sendPort.send(ret);
      return false;
    }
    print("wakelock enable");
    Wakelock.enable();
    return true;
  }

  static Future<ClientServiceError> sendRequest(String targetURL) async {
    final dio = Dio();
    try {
      final response = await dio.get(targetURL);
      print("response: ${response.statusCode}");
      if (response.statusCode != HttpStatus.ok) {
        print("unexpected response: ${response.statusCode}");
        return ClientServiceError.unexpectedResponseFailure;
      }
    } catch (e) {
      return ClientServiceError.hostCommunicationFailure;
    }
    return ClientServiceError.none;
  }
}
