import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class ClientPortInput extends StatelessWidget {
  const ClientPortInput({
    Key? key,
    this.readOnly = false,
  }) : super(key: key);

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
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
  }
}
