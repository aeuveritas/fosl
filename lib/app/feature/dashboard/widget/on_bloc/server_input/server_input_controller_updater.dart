import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/server_input/server_input_bloc.dart';

class ServerInputControllerUpdater extends StatelessWidget {
  const ServerInputControllerUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerInputBloc, ServerInputState>(
      bloc: Modular.get<ServerInputBloc>(),
      builder: (context, state) {
        final controllerBloc = Modular.get<ControllerBloc>();
        if (state.status == FormzStatus.valid) {
          controllerBloc.add(ValidateInput(
            serverPort: state.port.value,
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
