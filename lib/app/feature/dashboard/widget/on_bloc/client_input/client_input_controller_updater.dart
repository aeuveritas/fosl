import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';

class ClientInputControllerUpdater extends StatelessWidget {
  const ClientInputControllerUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientInputBloc, ClientInputState>(
      bloc: Modular.get<ClientInputBloc>(),
      builder: (context, state) {
        final controllerBloc = Modular.get<ControllerBloc>();
        if (state.status == FormzStatus.valid) {
          controllerBloc.add(ValidateInput(
            hostAddress: state.hostAddress.value,
            clientPort: state.port.value,
            syncInterval: state.syncInterval.value,
            isValid: true,
          ));
        } else {
          controllerBloc.add(const ValidateInput(isValid: false));
        }
        return Container();
      },
    );
  }
}
