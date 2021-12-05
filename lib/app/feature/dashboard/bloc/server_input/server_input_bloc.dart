import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:sleep_sync/app/core/service/hive/hive_service.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/port.dart';

part 'server_input_event.dart';
part 'server_input_state.dart';

class ServerInputBloc extends Bloc<ServerInputEvent, ServerInputState> {
  ServerInputBloc() : super(const ServerInputState()) {
    on<ServerInputBlocInit>(_onServerInputBlocInit);
    on<ServerPortChanged>(_onServerPortChanged);

    add(ServerInputBlocInit());
  }

  void _onServerInputBlocInit(
      ServerInputBlocInit event, Emitter<ServerInputState> emit) {
    final newStatus = Formz.validate([state.port]);

    final hiveService = Modular.get<HiveService>();
    emit(state.copyWith(
      port: Port.dirty(hiveService.serverPort),
      status: Formz.validate([state.port]),
    ));

    final controllerBloc = Modular.get<ControllerBloc>();
    final isValid = newStatus == FormzStatus.valid;
    if (isValid) {
      controllerBloc.add(ValidateInput(
        serverPort: state.port.value,
        hostAddress: "",
        clientPort: "",
        syncInterval: "",
        isValid: isValid,
      ));
    } else {
      controllerBloc.add(ValidateInput(
        isValid: isValid,
      ));
    }
  }

  void _onServerPortChanged(
      ServerPortChanged event, Emitter<ServerInputState> emit) {
    final port = Port.dirty(event.port);
    final newStatus = Formz.validate([port]);
    emit(state.copyWith(
      port: port,
      status: Formz.validate([port]),
    ));

    final controllerBloc = Modular.get<ControllerBloc>();
    final isValid = newStatus == FormzStatus.valid;
    if (isValid) {
      controllerBloc.add(ValidateInput(
        serverPort: port.value,
        hostAddress: "",
        clientPort: "",
        syncInterval: "",
        isValid: isValid,
      ));
    } else {
      controllerBloc.add(ValidateInput(
        isValid: isValid,
      ));
    }
  }
}
