import 'package:flutter/material.dart';
import 'package:sleep_sync/app/core/const/config.dart';

class ContentTile extends StatelessWidget {
  const ContentTile({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: 120,
              ),
              child: Text(
                title,
                style: defaultTextStyle,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: child,
          ),
        ),
      ],
    );
  }
}
