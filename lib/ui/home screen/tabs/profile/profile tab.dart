import 'package:event_planning/providers/app%20language%20provider.dart';
import 'package:event_planning/ui/auth/login/login%20screen.dart';
import 'package:event_planning/ui/home%20screen/tabs/profile/Theme%20bottom%20sheet.dart';
import 'package:event_planning/ui/home%20screen/tabs/profile/language%20bottom%20sheet.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:event_planning/utils/assets%20manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app theme provider.dart';
import '../../../../providers/event list provider.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * 0.20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
        title: Row(
          children: [
            Image.asset(AssetsManager.routeImage),
            SizedBox(
              width: width * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nada Khaled',
                  style: AppStyles.bold24White,
                ),
                Text(
                  'nada@gmail.com',
                  style: AppStyles.medium16White,
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: AppStyles.bold20Black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyles.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 35,
                      color: AppColors.primaryLight,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: AppStyles.bold20Black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.isDarkMode()
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: AppStyles.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 35,
                      color: AppColors.primaryLight,
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.01)),
                onPressed: () {
                  //empty event list
                  // eventListProvider.filterList=[];
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.logout,
                      style: AppStyles.regular20White,
                    )
                  ],
                )),
            SizedBox(
              height: height * 0.02,
            )
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
