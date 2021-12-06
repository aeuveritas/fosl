import 'package:flutter/material.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

import 'on_bloc/ip/ip_field.dart';
import 'on_bloc/server_input/server_input.dart';

class ServerForm extends StatelessWidget {
  const ServerForm({Key? key, required this.activeStatus}) : super(key: key);

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
          const ContentTile(
            title: "IP Address",
            child: Center(
              child: IPField(),
            ),
          ),
          const SizedBox(height: 16.0),
          ContentTile(
            title: "Port (30000 ~ 40000)",
            child: ServerPortInput(
              readOnly: readOnly,
            ),
          ),
        ],
      ),
    );
  }
}
