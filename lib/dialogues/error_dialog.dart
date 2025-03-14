import 'package:cinema_hub/dialogues/dialog_generic.dart';
import 'package:cinema_hub/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../models/generic_dialog_data.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  String? title,
  required String body,
  bool capitalizeBody = true,
}) {
  return showGenericDialog<void>(
    context: context,
    genericDialogData: GenericDialogData(
      title: title ?? 'Error',
      contentText: capitalizeBody ? body.capitalizeFirstLetterEachWord() : body,
      optionsBuilder: () => {'Ok': null},
    ),
  );
}
