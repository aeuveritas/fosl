part of 'server_input_bloc.dart';

class ServerInputState extends Equatable {
  const ServerInputState({
    this.status = FormzStatus.pure,
    this.port = const Port.pure(),
  });

  final FormzStatus status;
  final Port port;

  @override
  List<Object?> get props => [status, port];

  ServerInputState copyWith({
    FormzStatus? status,
    Port? port,
  }) {
    return ServerInputState(
      status: status ?? this.status,
      port: port ?? this.port,
    );
  }

  bool get valid => port.valid;
}
