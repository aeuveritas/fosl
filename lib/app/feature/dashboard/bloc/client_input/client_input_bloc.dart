import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:sleep_sync/app/core/service/hive/hive_service.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/host_address.dart';
import 'package:sleep_sync/app/feature/dashboard/model/port.dart';
import 'package:sleep_sync/app/feature/dashboard/model/sync_interval.dart';

part 'client_input_event.dart';
part 'client_input_state.dart';

class ClientInputBloc extends Bloc<ClientInputEvent, ClientInputState> {
  ClientInputBloc() : super(const ClientInputState()) {
    on<ClientInputBlocInit>(_onClientInputBlocInit);
    on<HostAddressChanged>(_onHostAddressChanged);
    on<ClientPortChanged>(_onClientPortChanged);
    on<SyncIntervalChanged>(_onSyncIntervalChanged);

    add(ClientInputBlocInit());
  }

  void _onClientInputBlocInit(
      ClientInputBlocInit event, Emitter<ClientInputState> emit) {
    final newStatus =
        Formz.validate([state.hostAddress, state.port, state.syncInterval]);
    final hiveService = Modular.get<HiveService>();
    emit(state.copyWith(
      hostAddress: HostAddress.dirty(hiveService.hostAddress),
      port: Port.dirty(hiveService.clientPort),
      syncInterval: SyncInterval.dirty(hiveService.syncInterval),
      status: newStatus,
    ));

    final controllerBloc = Modular.get<ControllerBloc>();
    final isValid = newStatus == FormzStatus.valid;
    if (isValid) {
      controllerBloc.add(ValidateInput(
        serverPort: "",
        hostAddress: state.hostAddress.value,
        clientPort: state.port.value,
        syncInterval: state.syncInterval.value,
        isValid: isValid,
      ));
    } else {
      controllerBloc.add(ValidateInput(
        isValid: isValid,
      ));
    }
  }

  void _onHostAddressChanged(
      HostAddressChanged event, Emitter<ClientInputState> emit) {
    final hostAddress = HostAddress.dirty(event.hostAddress);
    final newStatus =
        Formz.validate([hostAddress, state.port, state.syncInterval]);

    emit(state.copyWith(
      hostAddress: hostAddress,
      status: Formz.validate([hostAddress, state.port, state.syncInterval]),
    ));

    final controllerBloc = Modular.get<ControllerBloc>();
    final isValid = newStatus == FormzStatus.valid;
    if (isValid) {
      controllerBloc.add(ValidateInput(
        serverPort: "",
        hostAddress: hostAddress.value,
        clientPort: state.port.value,
        syncInterval: state.syncInterval.value,
        isValid: isValid,
      ));
    } else {
      controllerBloc.add(ValidateInput(
        isValid: isValid,
      ));
    }
  }

  void _onClientPortChanged(
      ClientPortChanged event, Emitter<ClientInputState> emit) {
    final port = Port.dirty(event.port);
    final newStatus =
        Formz.validate([state.hostAddress, port, state.syncInterval]);

    emit(state.copyWith(
      port: port,
      status: Formz.validate([state.hostAddress, port, state.syncInterval]),
    ));

    final controllerBloc = Modular.get<ControllerBloc>();
    final isValid = newStatus == FormzStatus.valid;
    if (isValid) {
      controllerBloc.add(ValidateInput(
        serverPort: "",
        hostAddress: state.hostAddress.value,
        clientPort: port.value,
        syncInterval: state.syncInterval.value,
        isValid: isValid,
      ));
    } else {
      controllerBloc.add(ValidateInput(
        isValid: isValid,
      ));
    }
  }

  void _onSyncIntervalChanged(
      SyncIntervalChanged event, Emitter<ClientInputState> emit) {
    final syncInterval = SyncInterval.dirty(event.syncInterval);
    final newStatus =
        Formz.validate([state.hostAddress, state.port, syncInterval]);

    emit(state.copyWith(
      syncInterval: syncInterval,
      status: Formz.validate([state.hostAddress, state.port, syncInterval]),
    ));

    final controllerBloc = Modular.get<ControllerBloc>();
    final isValid = newStatus == FormzStatus.valid;
    if (isValid) {
      controllerBloc.add(ValidateInput(
        serverPort: "",
        hostAddress: state.hostAddress.value,
        clientPort: state.port.value,
        syncInterval: syncInterval.value,
        isValid: isValid,
      ));
    } else {
      controllerBloc.add(ValidateInput(
        isValid: isValid,
      ));
    }
  }
}
