import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
          children: const [
            ActivateButton(),
            SizedBox(height: 24.0),
            ContentTile(
              title: "Mode",
              child: ModeSelector(),
            ),
            SizedBox(height: 24.0),
            ServerClientField(),
            SizedBox(height: 24.0),
            ErrorField(),
          ],
        ),
      ),
    );
  }
}
