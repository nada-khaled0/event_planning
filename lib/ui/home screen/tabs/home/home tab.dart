import 'package:event_planning/providers/event%20list%20provider.dart';
import 'package:event_planning/providers/user%20provider.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/event%20item%20widget.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/event%20tab%20widget.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:event_planning/utils/assets%20manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    eventListProvider.getEventsNameList(context);

    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular14White,
                ),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyles.bold24White,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.sunny,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.whiteColor,
                  ),
                  child: Text(
                    'En',
                    style: AppStyles.bold14Primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.01),
            height: height * 0.14,
            decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                )),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.iconMap),
                    Text(
                      'cairo,Egypt',
                      style: AppStyles.regular14White,
                    )
                  ],
                ),
                DefaultTabController(
                    length: eventListProvider.eventsNameList.length,
                    child: TabBar(
                        onTap: (index) {
                          eventListProvider.changeSelectedIndex(
                              index, userProvider.currentUser!.id);
                        },
                        isScrollable: true,
                        indicatorColor: AppColors.transparentColor,
                        dividerColor: AppColors.transparentColor,
                        tabAlignment: TabAlignment.start,
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: width * 0.01, vertical: height * 0.02),
                        tabs: eventListProvider.eventsNameList.map((eventName) {
                          return EventTabWidget(
                            eventName: eventName,
                            isSelected: eventListProvider.selectedIndex ==
                                eventListProvider.eventsNameList
                                    .indexOf(eventName),
                            backgroundColor: AppColors.whiteColor,
                            selectedTextStyle: AppStyles.medium16Primary,
                            unselectedTextStyle: AppStyles.medium16White,
                          );
                        }).toList()))
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: eventListProvider.filterList.isEmpty
                ? Center(
                    child: Text('no items found'),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return EventItemWidget(
                        event: eventListProvider.filterList[index],
                      );
                    },
                    itemCount: eventListProvider.filterList.length,
                  ),
          ))
        ],
      ),
    );
  }
}
