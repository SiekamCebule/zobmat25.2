import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

Future<void> showParameterHelpDialog({
  required BuildContext context,
  required DistributionParameter parameter,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 660),
          child: AlertDialog(
            title: Text(parameter.name),
            content: Text(parameter.description),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Ok'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
