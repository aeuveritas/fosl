import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sleep_sync/app/core/const/key.dart';
import 'package:sleep_sync/app/feature/dashboard/model/host_address.dart';
import 'package:sleep_sync/app/feature/dashboard/model/port.dart';
import 'package:sleep_sync/app/feature/dashboard/model/sync_interval.dart';

part 'client_input_event.dart';
part 'client_input_state.dart';

class ClientInputBloc extends Bloc<ClientInputEvent, ClientInputState>
    with HydratedMixin {
  ClientInputBloc() : super(const ClientInputState()) {
    on<HostAddressChanged>(_onHostAddressChanged);
    on<ClientPortChanged>(_onClientPortChanged);
    on<SyncIntervalChanged>(_onSyncIntervalChanged);
  }

  @override
  ClientInputState? fromJson(Map<String, dynamic> json) {
    return ClientInputState(
      status: FormzStatus.values[(json[HiveBoxClientInfoStatus] ?? 0)],
      hostAddress: HostAddress.dirty(json[HiveBoxHostAddress] ?? "0.0.0.0"),
      port: Port.dirty(json[HiveBoxClientPort] ?? "30000"),
      syncInterval: SyncInterval.dirty(json[HiveBoxSyncInterval] ?? "5"),
    );
  }

  @override
  Map<String, dynamic>? toJson(ClientInputState state) {
    if (!state.status.isValid) {
      return null;
    }

    return {
      HiveBoxClientInfoStatus: state.status.index,
      HiveBoxHostAddress: state.hostAddress.value,
      HiveBoxClientPort: state.port.value,
      HiveBoxSyncInterval: state.syncInterval.value,
    };
  }

  void _onHostAddressChanged(
      HostAddressChanged event, Emitter<ClientInputState> emit) {
    final hostAddress = HostAddress.dirty(event.hostAddress);

    emit(state.copyWith(
      hostAddress: hostAddress,
      status: Formz.validate([hostAddress, state.port, state.syncInterval]),
    ));
  }

  void _onClientPortChanged(
      ClientPortChanged event, Emitter<ClientInputState> emit) {
    final port = Port.dirty(event.port);

    emit(state.copyWith(
      port: port,
      status: Formz.validate([state.hostAddress, port, state.syncInterval]),
    ));
  }

  void _onSyncIntervalChanged(
      SyncIntervalChanged event, Emitter<ClientInputState> emit) {
    final syncInterval = SyncInterval.dirty(event.syncInterval);

    emit(state.copyWith(
      syncInterval: syncInterval,
      status: Formz.validate([state.hostAddress, state.port, syncInterval]),
    ));
  }
}
