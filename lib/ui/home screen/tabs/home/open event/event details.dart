import 'package:event_planning/ui/home%20screen/tabs/home/add%20event/add%20event.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/open%20event/edit%20event.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:event_planning/utils/assets%20manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../model/events.dart';
import '../../../../../providers/event list provider.dart';
import '../../../../../providers/user provider.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = 'details';

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.edit_event,
          style: AppStyles.medium20Primary,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditEvent.routeName, arguments: {
                  'image1': args['image'],
                  'title1': args['title'],
                  'description1': args['description'],
                  'date1': args['date'],
                  'time1': args['time'],
                });
              },
              icon: Icon(
                Icons.edit_outlined,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                String eventId = args['id'];
                eventListProvider.deleteEvent(
                    eventId, userProvider.currentUser!.id);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.redColor,
                size: 30,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                ),
                height: height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryLight, width: 2),
                    image: DecorationImage(
                        image: AssetImage(args['image']), fit: BoxFit.fill)),
              ),
              Text(
                args['title'],
                style: AppStyles.medium20Primary,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.008, horizontal: width * 0.02),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 2)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.02, horizontal: width * 0.04),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight),
                      child: Image.asset(AssetsManager.calender),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              args['date'].day.toString(),
                              style: AppStyles.medium16Primary,
                            ),
                            Text(
                              args['date'].month.toString(),
                              style: AppStyles.medium16Primary,
                            ),
                            Text(
                              args['date'].year.toString(),
                              style: AppStyles.medium16Primary,
                            ),
                          ],
                        ),
                        Text(
                          args['time'],
                          style: AppStyles.medium16Black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.008, horizontal: width * 0.02),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 2)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.02, horizontal: width * 0.04),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight),
                      child: Image.asset(AssetsManager.locationIcon),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Expanded(
                      child: Text(
                        'cairo',
                        style: AppStyles.medium16Primary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryLight,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryLight, width: 2),
                    color: AppColors.primaryLight),
                child: Text('hhhhhhhhh'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: AppStyles.medium16Black,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                args['description'],
                style: AppStyles.medium16Black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
