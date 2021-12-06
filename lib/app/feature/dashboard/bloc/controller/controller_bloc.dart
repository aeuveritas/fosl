import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sleep_sync/app/core/const/key.dart';
import 'package:sleep_sync/app/core/service/client/client_service.dart';
import 'package:sleep_sync/app/core/service/server/server_service.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState>
    with HydratedMixin {
  ControllerBloc() : super(const ControllerState.server()) {
    on<Activate>(_onActivate);
    on<Deactivate>(_onDeactivate);
    on<ModeChangeRequested>(_onModeChangeRequested);
    on<ValidateInput>(_onValidateInput);
  }

  StreamSubscription<bool>? _resultSubscription;

  @override
  ControllerState? fromJson(Map<String, dynamic> json) {
    final mode = ModeStatus.values[json[HiveBoxMode] ?? 0];

    if (mode == ModeStatus.server) {
      return const ControllerState.server();
    } else {
      return const ControllerState.client();
    }
  }

  @override
  Map<String, dynamic>? toJson(ControllerState state) {
    return {
      HiveBoxMode: state.mode.index,
    };
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
  }
}
