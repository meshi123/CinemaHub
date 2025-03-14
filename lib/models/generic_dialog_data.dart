import 'package:cinema_hub/dialogues/dialog_generic.dart';
import 'package:flutter/cupertino.dart';

class GenericDialogData {
  GenericDialogData({
    this.title,
    this.contentText,
    this.builderTitle,
    this.builderContent,
    this.optionsBuilder,
    this.contentTextAligment = TextAlign.center,
    this.onThen,
    this.onDialogContextAvailable,
  });

  GenericDialogData.empty({
    this.title = '',
    this.contentText,
    this.builderTitle,
    this.builderContent,
    this.optionsBuilder,
    this.contentTextAligment = TextAlign.center,
    this.onThen,
    this.onDialogContextAvailable,
  });

  final String? title;
  final String? contentText;
  final Widget Function(BuildContext)? builderTitle;
  final Widget Function(BuildContext)? builderContent;
  final DialogOptionBuilder? optionsBuilder;
  final TextAlign contentTextAligment;
  final VoidCallback? onThen;

  /// this will pass the context of the dialog, so that it can be manipulated externally
  Function(BuildContext)? onDialogContextAvailable;
}
