import 'package:cinema_hub/components/audi_log_item.dart';
import 'package:cinema_hub/enums/audi_log_type.dart';
import 'package:cinema_hub/extensions/enum_extensions.dart';
import 'package:cinema_hub/utils/utils.dart';
import 'package:flutter/material.dart';

class AudiLogTile extends StatelessWidget {
  const AudiLogTile({
    super.key,
    required this.audiNumber,
    this.audiLogType = AudiLogType.log,
    this.sizeBorder = 4,
  });

  final double sizeBorder;
  final AudiLogType audiLogType;
  final int audiNumber;

  @override
  Widget build(BuildContext context) {
    final colorAudi = getRandomColor();

    return Column(
      children: [
        // * Audtorium Circle
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorAudi,
            border: Border.all(
              color: Colors.white,
              width: 1.9,
            ),
          ),
          alignment: Alignment.center,
          // * Auditorium #
          child: Text(
            audiNumber.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // * Audi Logs
        Padding(
          padding: EdgeInsets.only(left: sizeBorder),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // * Audi log items
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    // 1,
                    5,
                    (i) => AudiLogItem(
                      auditLogType: AudiLogType.values.randomValue,
                      isComplete: toRandom5050(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
