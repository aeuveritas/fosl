import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class HostAddressInput extends StatelessWidget {
  const HostAddressInput({
    Key? key,
    this.readOnly = false,
  }) : super(key: key);

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientInputBloc, ClientInputState>(
      bloc: Modular.get<ClientInputBloc>(),
      buildWhen: (previous, current) =>
          previous.hostAddress != current.hostAddress,
      builder: (context, state) {
        return ModifiableTextField(
          key: const Key("clientForm_hostAddressInput_textField"),
          initialValue: state.hostAddress.value,
          onChanged: (hostAddress) => Modular.get<ClientInputBloc>()
              .add(HostAddressChanged(hostAddress)),
          errorText:
              state.hostAddress.invalid ? state.hostAddress.errorMessage : null,
          readOnly: readOnly,
        );
      },
    );
  }
}
