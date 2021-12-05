part of 'server_input_bloc.dart';

abstract class ServerInputEvent extends Equatable {
  const ServerInputEvent();
}

class ServerPortChanged extends ServerInputEvent {
  const ServerPortChanged(this.port);

  final String port;

  @override
  List<Object?> get props => [port];
}

class ServerInputBlocInit extends ServerInputEvent {
  @override
  List<Object?> get props => [];
}
