import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/bloc/controller/controller_bloc.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';
import 'package:sleep_sync/app/feature/dashboard/page/page.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sleep Sync",
          style: TextStyle(
            fontSize: 32.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ActivateButton(),
            const SizedBox(height: 24.0),
            const ModeSelector(),
            const SizedBox(height: 24.0),
            BlocBuilder<ControllerBloc, ControllerState>(
              bloc: Modular.get<ControllerBloc>(),
              builder: (context, state) {
                if (state.mode == ModeStatus.server) {
                  return const InternalServerPage();
                } else {
                  return const InternalClientPage();
                }
              },
            ),
            const SizedBox(height: 24.0),
            BlocBuilder<ControllerBloc, ControllerState>(
              bloc: Modular.get<ControllerBloc>(),
              builder: (context, state) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: errorTextStyle,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
