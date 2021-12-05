import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/server_input/server_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';

class PortInput extends StatelessWidget {
  const PortInput({Key? key, required this.mode}) : super(key: key);

  final ModeStatus mode;

  @override
  Widget build(BuildContext context) {
    if (mode == ModeStatus.client) {
      return BlocBuilder<ClientInputBloc, ClientInputState>(
        bloc: Modular.get<ClientInputBloc>(),
        buildWhen: (previous, current) => previous.port != current.port,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.port.value,
            key: const Key("clientForm_clientPortInput_textField"),
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              errorText: state.port.invalid ? state.port.errorMessage : null,
            ),
            onChanged: (port) =>
                Modular.get<ClientInputBloc>().add(ClientPortChanged(port)),
          );
        },
      );
    } else {
      return BlocBuilder<ServerInputBloc, ServerInputState>(
        bloc: Modular.get<ServerInputBloc>(),
        buildWhen: (previous, current) => previous.port != current.port,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.port.value,
            key: const Key("clientForm_serverPortInput_textField"),
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              errorText: state.port.invalid ? state.port.errorMessage : null,
            ),
            onChanged: (port) =>
                Modular.get<ServerInputBloc>().add(ServerPortChanged(port)),
          );
        },
      );
    }
  }
}
