import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/service/ip/ip_service.dart';

part 'ip_event.dart';
part 'ip_state.dart';

class IPBloc extends Bloc<IPEvent, IPState> {
  IPBloc() : super(const IPState()) {
    on<GetIP>(_onGetIP);

    add(const GetIP());
  }

  void _onGetIP(event, emit) async {
    final ipService = Modular.get<IPService>();
    final ip = await ipService.ip;

    emit(IPState(status: IPStatus.filled, ip: ip));
  }
}
