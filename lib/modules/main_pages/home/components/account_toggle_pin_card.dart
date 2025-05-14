import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountTogglePinCard extends StatelessWidget {
  const AccountTogglePinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 51,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors(context).backgroundPrimary,
      ),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(AssetConstants.lockIcon),
          Expanded(
            child: Text(
              "Картын нууц үг харах",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme(
                context,
              ).bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          CupertinoSwitch(
            value: false,
            activeTrackColor: colors(context).primary,
            inactiveTrackColor: colors(context).backgroundSecondary,
            thumbColor: colors(context).backgroundPrimary,
            inactiveThumbColor: colors(context).primary,
            onChanged: (e) {},
          ),
        ],
      ),
    );
  }
}
