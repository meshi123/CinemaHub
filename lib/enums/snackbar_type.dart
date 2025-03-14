import 'package:cinema_hub/utils/app_colors.dart' show AppColors;

enum SnackbarType {
  success,
  error,
  email,
}

extension SnackbarTypeExtension on SnackbarType {
  toColor() {
    switch (this) {
      case SnackbarType.success:
        return AppColors.colorSuccess;
      case SnackbarType.error:
        return AppColors.colorBtnDelete;
      case SnackbarType.email:
        return AppColors.colorEmail;
    }
  }
}
