import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';

class ErrorField extends StatelessWidget {
  const ErrorField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ControllerBloc, ControllerState, String>(
      bloc: Modular.get<ControllerBloc>(),
      selector: (state) => state.errorMessage,
      builder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: errorTextStyle,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
