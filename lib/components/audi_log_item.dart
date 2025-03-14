import 'package:cinema_hub/components/UI/checkmark_box.dart';
import 'package:cinema_hub/enums/audi_log_type.dart';
import 'package:cinema_hub/extensions/datetime_extension.dart';
import 'package:cinema_hub/utils/app_colors.dart';
import 'package:cinema_hub/utils/utils.dart';
import 'package:flutter/material.dart';

class AudiLogItem extends StatelessWidget {
  const AudiLogItem({
    super.key,
    this.auditLogType = AudiLogType.log,
    this.isComplete = true,
  });

  final AudiLogType auditLogType;
  // todo: change to a nullable and implement a 'Log missed' state
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    const double sizeIcon = 20;
    const double sizeFont = 15;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // * Tile
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.colorPrimaryLighter,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                // * Tile Type
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border(
                    left: BorderSide(
                      color: auditLogType.toColor(),
                      width: 3,
                    ),
                  ),
                ),
                // * Tile Elements
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // * Time Left
                      SizedBox(
                        width: 75,
                        child: Column(
                          children: [
                            // * Due Time
                            Text(
                              DateTime.now()
                                  .add(Duration(
                                      minutes: getRandomNumber(0, 100)))
                                  .toTimeLeft(
                                    shortFormat: true,
                                    shortFormatWithSeconds: true,
                                  ),
                              style: const TextStyle(
                                fontSize: sizeFont,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // * Progress bar
                            LinearProgressIndicator(
                              value: .75,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.blue),
                              backgroundColor: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // * Viewers
                      SizedBox(
                        width: 75,
                        child: Column(
                          children: [
                            // * Viewers icon
                            const Icon(
                              Icons.groups_sharp,
                              size: sizeIcon,
                            ),
                            Text(
                              '${getRandomNumber(0, 200)}/200',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: sizeFont,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // * Due Time
                      Column(
                        children: [
                          // * Time Icon
                          const Icon(
                            Icons.schedule,
                            size: sizeIcon,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 2.5),
                          // * Due Time
                          Text(
                            DateTime.now()
                                .add(Duration(minutes: getRandomNumber(0, 100)))
                                .toStringTime(),
                            style: const TextStyle(
                              fontSize: sizeFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // * 'Completed' checkbox
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CheckmarkBox(isChecked: isComplete),
          ),
        ],
      ),
    );
  }
}
