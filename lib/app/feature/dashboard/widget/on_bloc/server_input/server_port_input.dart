import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/server_input/server_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class ServerPortInput extends StatelessWidget {
  const ServerPortInput({
    Key? key,
    this.readOnly = false,
  }) : super(key: key);

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
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
