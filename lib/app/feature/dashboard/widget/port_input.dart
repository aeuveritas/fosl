import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/server_input/server_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class PortInput extends StatelessWidget {
  const PortInput({
    Key? key,
    required this.mode,
    this.readOnly = false,
  }) : super(key: key);

  final ModeStatus mode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    if (mode == ModeStatus.client) {
      return BlocBuilder<ClientInputBloc, ClientInputState>(
        bloc: Modular.get<ClientInputBloc>(),
        buildWhen: (previous, current) => previous.port != current.port,
        builder: (context, state) {
          return ModifiableTextField(
            key: const Key("clientForm_clientPortInput_textField"),
            initialValue: state.port.value,
            onChanged: (port) =>
                Modular.get<ClientInputBloc>().add(ClientPortChanged(port)),
            errorText: state.port.invalid ? state.port.errorMessage : null,
            readOnly: readOnly,
          );
        },
      );
    } else {
      return BlocBuilder<ServerInputBloc, ServerInputState>(
        bloc: Modular.get<ServerInputBloc>(),
        buildWhen: (previous, current) => previous.port != current.port,
        builder: (context, state) {
          return ModifiableTextField(
            key: const Key("clientForm_serverPortInput_textField"),
            initialValue: state.port.value,
            onChanged: (port) =>
                Modular.get<ServerInputBloc>().add(ServerPortChanged(port)),
            errorText: state.port.invalid ? state.port.errorMessage : null,
            readOnly: readOnly,
          );
        },
      );
    }
  }
}
