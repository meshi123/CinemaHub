import 'package:cinema_hub/components/UI/menu_button.dart';
import 'package:cinema_hub/components/audi_log_tile.dart';
import 'package:cinema_hub/enums/audi_log_type.dart';
import 'package:cinema_hub/extensions/enum_extensions.dart';
import 'package:flutter/material.dart';

class AudiLogsView extends StatelessWidget {
  const AudiLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // * Change View btns
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            children: [
              // * Group by audit
              MenuButton(
                iconData: Icons.view_list_rounded,
                isActive: true,
                onTap: () {},
              ),
              // * Sort by 'soonest'
              MenuButton(
                iconData: Icons.schedule,
                onTap: () {},
              ),
            ],
          ),
        ),
        // * Audits
        Expanded(
          child: ListView.builder(
            // itemCount: 1,
            itemCount: 5,
            itemBuilder: (context, i) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: AudiLogTile(
                  audiLogType: AudiLogType.values.randomValue,
                  audiNumber: i + 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
