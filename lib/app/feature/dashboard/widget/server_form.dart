import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/ip/ip_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class ServerForm extends StatelessWidget {
  const ServerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    width: 120,
                  ),
                  child: const Text(
                    "IP Address",
                    style: defaultTextStyle,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: BlocBuilder<IPBloc, IPState>(
                  bloc: Modular.get<IPBloc>(),
                  builder: (context, state) {
                    return Text(
                      state.ip,
                      style: defaultTextStyle,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    width: 120,
                  ),
                  child: const Text(
                    "Port (30000 ~ 40000)",
                    style: defaultTextStyle,
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: Center(
                child: PortInput(mode: ModeStatus.server),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
