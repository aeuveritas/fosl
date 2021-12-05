import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';

class ActivateButton extends StatelessWidget {
  const ActivateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints.tightFor(width: double.infinity, height: 64.0),
      child: BlocBuilder<ControllerBloc, ControllerState>(
        bloc: Modular.get<ControllerBloc>(),
        builder: (context, state) {
          return ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              backgroundColor: state.status == ActivateStatus.active
                  ? MaterialStateProperty.all(Colors.redAccent)
                  : MaterialStateProperty.all(Colors.blueAccent),
            ),
            onPressed: state.inputValid
                ? () {
                    final controllerBloc = Modular.get<ControllerBloc>();
                    if (state.status == ActivateStatus.active) {
                      controllerBloc.add(const Deactivate());
                    } else {
                      controllerBloc.add(const Activate());
                    }
                  }
                : null,
            child: Text(
              state.status == ActivateStatus.active ? "Deactivate" : "Activate",
              style: defaultTextStyle,
            ),
          );
        },
      ),
    );
  }
}
