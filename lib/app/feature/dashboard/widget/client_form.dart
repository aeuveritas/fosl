import 'package:flutter/material.dart';
import 'package:sleep_sync/app/core/const/config.dart';
import 'package:sleep_sync/app/feature/dashboard/model/model.dart';
import 'package:sleep_sync/app/feature/dashboard/widget/widget.dart';

class ClientForm extends StatelessWidget {
  const ClientForm({Key? key}) : super(key: key);

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
                    "Host Address",
                    style: defaultTextStyle,
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: Center(
                child: HostAddressInput(),
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
                child: PortInput(mode: ModeStatus.client),
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
                    "Sync Interval (min)",
                    style: defaultTextStyle,
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: Center(
                child: SyncIntervalInput(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
