import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/dashboard.dart';

import '../../client_form.dart';
import '../../server_form.dart';

class ServerClientField extends StatelessWidget {
  const ServerClientField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControllerBloc, ControllerState>(
      bloc: Modular.get<ControllerBloc>(),
      builder: (context, state) {
        if (state.mode == ModeStatus.server) {
          return ServerForm(activeStatus: state.status);
        } else {
          return ClientForm(activeStatus: state.status);
        }
      },
    );
  }
}
