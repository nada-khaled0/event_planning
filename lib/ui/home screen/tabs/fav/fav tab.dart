import 'package:event_planning/widget/custom%20text%20field.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/event%20item%20widget.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event list provider.dart';
import '../../../../providers/user provider.dart';

class FavTab extends StatefulWidget {
  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (eventListProvider.favEventList.isEmpty) {
      eventListProvider.getFavouriteEvent(userProvider.currentUser!.id);
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: [
              CustomTextField(
                borderColor: AppColors.primaryLight,
                hintText: AppLocalizations.of(context)!.search_event,
                hintStyle: AppStyles.bold14Primary,
                prefixIcon: Icon(
                  Icons.search,
                  size: 24,
                  color: AppColors.primaryLight,
                ),
              ),
              Expanded(
                  child: eventListProvider.favEventList.isEmpty
                      ? Center(
                          child: Text('no items found'),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return EventItemWidget(
                              event: eventListProvider.favEventList[index],
                            );
                          },
                          itemCount: eventListProvider.favEventList.length,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
