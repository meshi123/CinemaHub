import 'package:flutter/material.dart';
import '../models/generic_dialog_data.dart';

typedef DialogOptionBuilder<T> = Map<String, VoidCallback?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required GenericDialogData genericDialogData,
}) {
  final title = genericDialogData.title;
  final contentText = genericDialogData.contentText;
  final contentWidget = genericDialogData.builderContent;
  final optionsBuilder = genericDialogData.optionsBuilder;

  final options = optionsBuilder?.call() ?? {};

  return showDialog(
    context: context,
    builder: (context) {
      // Invoke the callback to pass the dialog context
      if (genericDialogData.onDialogContextAvailable != null) {
        genericDialogData.onDialogContextAvailable!(context);
      }

      // title
      final widgetTitle = genericDialogData.builderTitle?.call(context) ??
          Center(
            child: Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
      // body
      final widgetContent = Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: contentText != null
            ? Text(
                genericDialogData.contentText!,
                style: const TextStyle(
                  fontSize: 15,
                ),
                textAlign: genericDialogData.contentTextAligment,
              )
            : contentWidget?.call(context) ?? Container(),
      );

      // btns
      final actions = options.keys.map((optionTitle) {
        final callback = options[optionTitle];
        return TextButton(
          onPressed: () {
            if (callback != null) {
              Navigator.of(context).pop(callback);
              callback.call();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            optionTitle,
            textAlign: TextAlign.end,
          ),
        );
      }).toList();

      // provide a dialog for both platforms
      final dialog = AlertDialog.adaptive(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: widgetTitle,
        content: widgetContent,
        actions: actions,
      );

      return dialog;
    },
  ).then((_) {
    genericDialogData.onThen?.call();
    return null;
  });
}
