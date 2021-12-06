import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class SyncIntervalInput extends StatelessWidget {
  const SyncIntervalInput({
    Key? key,
    this.readOnly = false,
  }) : super(key: key);

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientInputBloc, ClientInputState>(
      bloc: Modular.get<ClientInputBloc>(),
      buildWhen: (previous, current) =>
          previous.syncInterval != current.syncInterval,
      builder: (context, state) {
        return ModifiableTextField(
          key: const Key("clientForm_syncIntervalInput_textField"),
          initialValue: state.syncInterval.value,
          onChanged: (syncInterval) => Modular.get<ClientInputBloc>()
              .add(SyncIntervalChanged(syncInterval)),
          errorText: state.syncInterval.invalid
              ? state.syncInterval.errorMessage
              : null,
          readOnly: readOnly,
        );
      },
    );
  }
}
