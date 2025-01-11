import 'package:event_planning/providers/app%20language%20provider.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../preference.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                languageProvider.changeLanguage('en');
                SharedPreferenceClass.setLanguage('en');
              },
              child: languageProvider.appLanguage == 'en'
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.english)),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
              onTap: () {
                languageProvider.changeLanguage('ar');
                SharedPreferenceClass.setLanguage('ar');
              },
              child: languageProvider.appLanguage == 'ar'
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.arabic))
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyles.bold20Primary,
        ),
        Icon(
          Icons.check,
          size: 25,
          color: AppColors.primaryLight,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(
      text,
      style: AppStyles.bold20Black,
    );
  }
}
