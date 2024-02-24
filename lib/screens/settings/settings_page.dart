import 'dart:io';

import 'package:dogs_case/constants/assets.dart';
import 'package:dogs_case/constants/colors.dart';
import 'package:dogs_case/constants/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String version = '';
  @override
  void initState() {
    _getSystemVersion();
    super.initState();
  }

  _getSystemVersion() async {
    const platform = MethodChannel('callNewChannel');
    await platform.invokeMethod('getSystemVersion').then((val) {
      if (val != null) {
        setState(() => version = val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 4,
            width: 36,
            margin: const EdgeInsets.only(top: 15, bottom: 50),
            decoration: const BoxDecoration(
                color: AppColors.mainGrey,
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          _settingRow(Assets.help, StringUtils.help),
          _settingRow(Assets.star, StringUtils.rateUs),
          _settingRow(Assets.share, StringUtils.shareWithFriends),
          _settingRow(Assets.terms, StringUtils.termsOfUse),
          _settingRow(Assets.policy, StringUtils.privacyPolicy),
          _settingRow(
              Assets.version,
              Platform.isAndroid
                  ? StringUtils.androidVersion
                  : StringUtils.osVersion,
              osVersion: version),
        ],
      ),
    );
  }

  _settingRow(String icon, String title, {String? osVersion}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Flexible(fit: FlexFit.tight, child: SizedBox()),
              osVersion == null
                  ? SvgPicture.asset(
                      Assets.arrowUpRight,
                    )
                  : Text(
                      version,
                      style: const TextStyle(color: Color(0xFF3C3C43)),
                    ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (osVersion == null)
            const Divider(
              color: AppColors.mainGrey,
              thickness: 2,
            ),
        ],
      ),
    );
  }
}
