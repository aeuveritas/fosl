import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';

class HostAddressInput extends StatelessWidget {
  const HostAddressInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientInputBloc, ClientInputState>(
      bloc: Modular.get<ClientInputBloc>(),
      buildWhen: (previous, current) =>
          previous.hostAddress != current.hostAddress,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.hostAddress.value,
          key: const Key("clientForm_hostAddressInput_textField"),
          style: defaultTextStyle,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            errorText: state.hostAddress.invalid
                ? state.hostAddress.errorMessage
                : null,
          ),
          onChanged: (hostAddress) => Modular.get<ClientInputBloc>()
              .add(HostAddressChanged(hostAddress)),
        );
      },
    );
  }
}
