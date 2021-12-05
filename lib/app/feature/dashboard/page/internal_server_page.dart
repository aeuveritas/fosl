import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/server_input/server_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/server_form.dart';

class InternalServerPage extends StatelessWidget {
  const InternalServerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serverInputBloc = Modular.get<ServerInputBloc>();
    serverInputBloc.add(ServerInputBlocInit());

    return const Material(
      child: ServerForm(),
    );
  }
}
