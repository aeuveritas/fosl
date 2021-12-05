import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  width: 120,
                ),
                child: const Text(
                  "Mode",
                  style: defaultTextStyle,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: BlocBuilder<ControllerBloc, ControllerState>(
                bloc: Modular.get<ControllerBloc>(),
                builder: (context, state) {
                  return ToggleButtons(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.31,
                        minHeight: 60),
                    children: const [Text("Server"), Text("Client")],
                    onPressed: state.status == ActivateStatus.active
                        ? null
                        : (int index) {
                            final nextMode = ModeStatus.values.toList()[index];
                            Modular.get<ControllerBloc>()
                                .add(ModeChangeRequested(nextMode: nextMode));
                          },
                    isSelected: state.modeList,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    selectedBorderColor: Colors.blueAccent,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
