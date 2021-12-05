import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class ClientForm extends StatelessWidget {
  const ClientForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControllerBloc, ControllerState>(
      bloc: Modular.get<ControllerBloc>(),
      builder: (context, state) {
        bool readOnly = false;
        if (state.status == ActivateStatus.active) {
          readOnly = true;
        }
        return Column(
          children: [
            TextFieldTile(
              title: "Host Address",
              child: HostAddressInput(readOnly: readOnly),
            ),
            const SizedBox(height: 16.0),
            TextFieldTile(
              title: "Port (30000 ~ 40000)",
              child: PortInput(
                mode: ModeStatus.client,
                readOnly: readOnly,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFieldTile(
              title: "Sync Interval (min)",
              child: SyncIntervalInput(readOnly: readOnly),
            ),
          ],
        );
      },
    );
  }
}
