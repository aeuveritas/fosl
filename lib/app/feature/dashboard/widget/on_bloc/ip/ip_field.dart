import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/ip/ip_bloc.dart';

class IPField extends StatelessWidget {
  const IPField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IPBloc, IPState>(
      bloc: Modular.get<IPBloc>(),
      builder: (context, state) {
        return Text(
          state.ip,
          style: defaultTextStyle,
        );
      },
    );
  }
}
