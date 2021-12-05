import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';

class SyncIntervalInput extends StatelessWidget {
  const SyncIntervalInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientInputBloc, ClientInputState>(
      bloc: Modular.get<ClientInputBloc>(),
      buildWhen: (previous, current) =>
          previous.syncInterval != current.syncInterval,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.syncInterval.value,
          key: const Key("clientForm_syncIntervalInput_textField"),
          style: defaultTextStyle,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            errorText: state.syncInterval.invalid
                ? state.syncInterval.errorMessage
                : null,
          ),
          onChanged: (syncInterval) => Modular.get<ClientInputBloc>()
              .add(SyncIntervalChanged(syncInterval)),
        );
      },
    );
  }
}
