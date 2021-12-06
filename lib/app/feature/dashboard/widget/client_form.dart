import 'package:flutter/material.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

import 'on_bloc/client_input/client_input.dart';

class ClientForm extends StatelessWidget {
  const ClientForm({Key? key, required this.activeStatus}) : super(key: key);

  final ActivateStatus activeStatus;

  @override
  Widget build(BuildContext context) {
    bool readOnly = false;
    if (activeStatus == ActivateStatus.active) {
      readOnly = true;
    }

    return Material(
      child: Column(
        children: [
          ContentTile(
            title: "Host Address",
            child: HostAddressInput(readOnly: readOnly),
          ),
          const SizedBox(height: 16.0),
          ContentTile(
            title: "Port (30000 ~ 40000)",
            child: ClientPortInput(
              readOnly: readOnly,
            ),
          ),
          const SizedBox(height: 16.0),
          ContentTile(
            title: "Sync Interval (min)",
            child: SyncIntervalInput(readOnly: readOnly),
          ),
        ],
      ),
    );
  }
}
