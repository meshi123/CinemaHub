// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../enums/snackbar_type.dart';

class SnackBarData {
  SnackBarData({
    required this.text,
    this.scalerDuration = 1,
    this.snackbarType = SnackbarType.email,
    this.capitalizeFirstWord = true,
  });

  final String text;
  final double scalerDuration;
  final SnackbarType snackbarType;
  final bool capitalizeFirstWord;
}
