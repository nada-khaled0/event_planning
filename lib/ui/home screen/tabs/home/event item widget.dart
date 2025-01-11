import 'package:event_planning/model/events.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/open%20event/event%20details.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:event_planning/utils/assets%20manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event list provider.dart';
import '../../../../providers/user provider.dart';

class EventItemWidget extends StatelessWidget {
  Event event;

  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EventDetails.routeName, arguments: {
          'image': event.image,
          'title': event.title,
          'description': event.description,
          'date': event.dateTime,
          'time': event.time,
          'id': event.id
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        height: height * 0.30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primaryLight, width: 2),
            image: DecorationImage(
                image: AssetImage(
                  event.image,
                ),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.005),
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.008),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.dateTime.day.toString(),
                    style: AppStyles.bold20Primary,
                  ),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    style: AppStyles.bold20Primary,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.005),
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.008),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    event.title,
                    style: AppStyles.bold14Black,
                  )),
                  InkWell(
                      onTap: () {
                        eventListProvider.updateFavouriteEvent(
                            event, userProvider.currentUser!.id);
                      },
                      child: Image.asset(
                        event.isFavourite == true
                            ? AssetsManager.iconFavSelected
                            : AssetsManager.iconFav,
                        color: AppColors.primaryLight,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
