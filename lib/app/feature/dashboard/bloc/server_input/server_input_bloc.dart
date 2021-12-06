import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sleep_sync/app/core/const/key.dart';
import 'package:sleep_sync/app/feature/dashboard/model/port.dart';

part 'server_input_event.dart';
part 'server_input_state.dart';

class ServerInputBloc extends Bloc<ServerInputEvent, ServerInputState>
    with HydratedMixin {
  ServerInputBloc() : super(const ServerInputState()) {
    on<ServerPortChanged>(_onServerPortChanged);
  }

  @override
  ServerInputState? fromJson(Map<String, dynamic> json) {
    return ServerInputState(
      status: FormzStatus.values[(json[HiveBoxServerInfoStatus] ?? 0)],
      port: Port.dirty(json[HiveBoxServerPort] ?? "30000"),
    );
  }

  @override
  Map<String, dynamic>? toJson(ServerInputState state) {
    if (!state.status.isValid) {
      return null;
    }

    return {
      HiveBoxServerInfoStatus: state.status.index,
      HiveBoxServerPort: state.port.value,
    };
  }

  void _onServerPortChanged(
      ServerPortChanged event, Emitter<ServerInputState> emit) {
    final port = Port.dirty(event.port);
    emit(state.copyWith(
      port: port,
      status: Formz.validate([port]),
    ));
  }
}
