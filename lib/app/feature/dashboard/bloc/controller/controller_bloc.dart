import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/service/client/client_service.dart';
import 'package:sleep_sync/app/core/service/hive/hive_service.dart';
import 'package:sleep_sync/app/core/service/server/server_service.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  ControllerBloc() : super(const ControllerState.server()) {
    on<Init>(_onInit);
    on<Activate>(_onActivate);
    on<Deactivate>(_onDeactivate);
    on<ModeChangeRequested>(_onModeChangeRequested);
    on<ValidateInput>(_onValidateInput);

    add(const Init());
  }

  StreamSubscription<bool>? _resultSubscription;

  void _onInit(Init event, Emitter<ControllerState> emit) {
    final hiveService = Modular.get<HiveService>();
    final modeInBox = hiveService.mode;

    if (modeInBox == state.mode) {
      return;
    }

    if (modeInBox == ModeStatus.server) {
      emit(const ControllerState.server());
    } else {
      emit(const ControllerState.client());
    }
  }

  void _onActivate(Activate event, Emitter<ControllerState> emit) async {
    switch (state.mode) {
      case ModeStatus.server:
        final serverService = Modular.get<ServerService>();
        await serverService.start(state.serverPort);
        break;
      case ModeStatus.client:
        final clientService = Modular.get<ClientService>();
        _resultSubscription = clientService
            .start(
          state.hostAddress,
          state.clientPort,
          state.syncInterval,
        )
            .listen(
          (_) {},
          onError: (error) {
            add(Deactivate(errorMessage: error.toString()));
          },
        );
        break;
      default:
    }

    emit(state.activate());
  }

  void _onDeactivate(Deactivate event, Emitter<ControllerState> emit) async {
    switch (state.mode) {
      case ModeStatus.server:
        final serverService = Modular.get<ServerService>();
        serverService.stop();
        break;
      case ModeStatus.client:
        if (_resultSubscription != null) {
          _resultSubscription!.cancel();
        }

        final clientService = Modular.get<ClientService>();
        clientService.stop();
        break;
      default:
    }

    emit(state.deactivate(event.errorMessage));
  }

  void _onModeChangeRequested(
      ModeChangeRequested event, Emitter<ControllerState> emit) {
    final currentMode = state.mode;
    if (event.nextMode != currentMode) {
      switch (event.nextMode) {
        case ModeStatus.server:
          emit(const ControllerState.server());
          break;
        case ModeStatus.client:
          emit(const ControllerState.client());
          break;
        default:
      }

      final hiveService = Modular.get<HiveService>();
      hiveService.setMode(event.nextMode);
    }
  }

  void _onValidateInput(ValidateInput event, Emitter<ControllerState> emit) {
    emit(state.copyWith(
      serverPort: event.serverPort,
      hostAddress: event.hostAddress,
      clientPort: event.clientPort,
      syncInterval: event.syncInterval,
      inputValid: event.isValid,
    ));

    if (event.isValid) {
      if (state.mode == ModeStatus.server) {
        _saveServerInfo();
      } else {
        _saveClientInfo();
      }
    }
  }

  Future<void> _saveClientInfo() async {
    final hiveService = Modular.get<HiveService>();
    await hiveService.setHostAddress(state.hostAddress);
    await hiveService.setClientPort(state.clientPort);
    await hiveService.setSyncInterval(state.syncInterval);
  }

  Future<void> _saveServerInfo() async {
    final hiveService = Modular.get<HiveService>();
    await hiveService.setServerPort(state.serverPort);
  }
}
