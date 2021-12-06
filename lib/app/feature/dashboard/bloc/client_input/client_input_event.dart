part of 'client_input_bloc.dart';

abstract class ClientInputEvent extends Equatable {
  const ClientInputEvent();
}

class HostAddressChanged extends ClientInputEvent {
  const HostAddressChanged(this.hostAddress);

  final String hostAddress;

  @override
  List<Object?> get props => [hostAddress];
}

class ClientPortChanged extends ClientInputEvent {
  const ClientPortChanged(this.port);

  final String port;

  @override
  List<Object?> get props => [port];
}

class SyncIntervalChanged extends ClientInputEvent {
  const SyncIntervalChanged(this.syncInterval);

  final String syncInterval;

  @override
  List<Object?> get props => [syncInterval];
}
