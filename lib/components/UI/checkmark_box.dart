import 'package:flutter/material.dart';

class CheckmarkBox extends StatelessWidget {
  const CheckmarkBox({
    super.key,
    this.isChecked,
  });

  /// Pass [null] to cross out, [false] to uncheck, [true] to check
  final bool? isChecked;

  @override
  Widget build(BuildContext context) {
    final crossOut = isChecked == null;
    final check = isChecked == true;

    return Container(
      width: 27.5,
      height: 27.5,
      decoration: BoxDecoration(
        color: crossOut
            ? Colors.red
            : check
                ? Colors.green
                : Colors.transparent,
        border: Border.all(
          color: crossOut
              ? Colors.red
              : check
                  ? Colors.green
                  : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: crossOut
          ? const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            )
          : check
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                )
              : null,
    );
  }
}
