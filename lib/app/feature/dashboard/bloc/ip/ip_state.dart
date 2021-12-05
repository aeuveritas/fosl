part of 'ip_bloc.dart';

enum IPStatus { empty, filled }

class IPState extends Equatable {
  const IPState({
    this.status = IPStatus.empty,
    this.ip = "",
  });

  final IPStatus status;
  final String ip;

  IPState copyWith({
    IPStatus? status,
    String? ip,
  }) {
    return IPState(
      status: status ?? this.status,
      ip: ip ?? this.ip,
    );
  }

  @override
  List<Object?> get props => [status, ip];
}
