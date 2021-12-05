import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/client_input/client_input_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/client_form.dart';

class InternalClientPage extends StatelessWidget {
  const InternalClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientInputBloc = Modular.get<ClientInputBloc>();
    clientInputBloc.add(ClientInputBlocInit());

    return const Material(
      child: ClientForm(),
    );
  }
}
