part of 'client_input_bloc.dart';

class ClientInputState extends Equatable {
  const ClientInputState({
    this.status = FormzStatus.pure,
    this.hostAddress = const HostAddress.pure(),
    this.port = const Port.pure(),
    this.syncInterval = const SyncInterval.pure(),
  });

  final FormzStatus status;
  final HostAddress hostAddress;
  final Port port;
  final SyncInterval syncInterval;

  @override
  List<Object?> get props => [status, hostAddress, port, syncInterval];

  ClientInputState copyWith({
    FormzStatus? status,
    HostAddress? hostAddress,
    Port? port,
    SyncInterval? syncInterval,
  }) {
    return ClientInputState(
      status: status ?? this.status,
      hostAddress: hostAddress ?? this.hostAddress,
      port: port ?? this.port,
      syncInterval: syncInterval ?? this.syncInterval,
    );
  }

  bool get valid => hostAddress.valid && port.valid && syncInterval.valid;
}
