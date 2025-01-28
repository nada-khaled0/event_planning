import 'package:event_planning/ui/home%20screen/tabs/fav/fav%20tab.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/add%20event/add%20event.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/home%20tab.dart';
import 'package:event_planning/ui/home%20screen/tabs/map/map%20tab.dart';
import 'package:event_planning/ui/home%20screen/tabs/profile/profile%20tab.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/assets%20manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: AppColors.transparentColor
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Theme
              .of(context)
              .primaryColor,
          notchMargin: 4,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {

                });
              },
              items: [
                buildBottomNavItems(
                    index: 0,
                    iconSelectedName: AssetsManager.iconHomeSelected,
                    iconName: AssetsManager.iconHome,
                    label: AppLocalizations.of(context)!.home
                ),
                buildBottomNavItems(
                    index: 1,
                    iconSelectedName: AssetsManager.iconMapSelected,
                    iconName: AssetsManager.iconMap,
                    label: AppLocalizations.of(context)!.map
                ),
                buildBottomNavItems(
                    index: 2,
                    iconSelectedName: AssetsManager.iconFavSelected,
                    iconName: AssetsManager.iconFav,
                    label: AppLocalizations.of(context)!.love
                ),
                buildBottomNavItems(
                    index: 3,
                    iconSelectedName: AssetsManager.iconProfileSelected,
                    iconName: AssetsManager.iconProfile,
                    label: AppLocalizations.of(context)!.profile
                ),
              ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 35,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavItems({required int index,
    required String iconSelectedName, required String iconName, required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
          AssetImage(selectedIndex == index ? iconSelectedName : iconName)),
      label: label,
    );
  }
}
