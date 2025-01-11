import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/events.dart';
import 'package:event_planning/providers/user%20provider.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/event%20tab%20widget.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:event_planning/utils/assets%20manager.dart';
import 'package:event_planning/widget/choose%20date%20or%20time.dart';
import 'package:event_planning/widget/custom%20elevated%20button.dart';
import 'package:event_planning/widget/custom%20text%20field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/event list provider.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'event';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime? selectedDate;
  String formatedDate = '';
  TimeOfDay? selectedTime;
  String formatedTime = '';
  String selectedImage = '';
  String selectedEventName = '';
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String> imageList = [
      AssetsManager.sportImage,
      AssetsManager.birthdayImage,
      AssetsManager.meetingImage,
      AssetsManager.gamingImage,
      AssetsManager.workShopImage,
      AssetsManager.bookClubImage,
      AssetsManager.exhibitionImage,
      AssetsManager.holidayImage,
      AssetsManager.eatingImage
    ];
    selectedImage = imageList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex];

    /*Map<String,String> mapList={
      AppLocalizations.of(context)!.sport:AssetsManager.sportImage,
    };*/

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.create_Event,
          style: AppStyles.medium20Primary,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryLight),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.01),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Image.asset(AssetsManager.birthdayImage),
                  clipBehavior: Clip.antiAlias,
                )*/
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  //mapList[eventNameList[selectedindex]]!
                  imageList[selectedIndex],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.05,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          eventListProvider.changeSelectedIndex(
                              index, userProvider.currentUser!.id);
                        },
                        child: EventTabWidget(
                          isSelected: selectedIndex == index,
                          eventName: eventsNameList[index],
                          backgroundColor: AppColors.primaryLight,
                          selectedTextStyle: AppStyles.medium16White,
                          unselectedTextStyle: AppStyles.medium16Primary,
                          borderColor: AppColors.primaryLight,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: width * 0.02,
                      );
                    },
                    itemCount: eventsNameList.length),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.title,
                        style: AppStyles.medium16Black,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        controller: titleController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .notification; //invalid
                          }
                          return null; //valid
                        },
                        hintText: AppLocalizations.of(context)!.event_Title,
                        hintStyle: AppStyles.medium16Grey,
                        prefixIcon: Image.asset(AssetsManager.titleIcon),
                        borderColor: AppColors.greyColor,
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
                      CustomTextField(
                        controller: descriptionController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .notification; //invalid
                          }
                          return null; //valid
                        },
                        maxLines: 4,
                        hintText:
                            AppLocalizations.of(context)!.event_Description,
                        hintStyle: AppStyles.medium16Grey,
                        borderColor: AppColors.greyColor,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ChooseDateOrTime(
                          iconName: AssetsManager.dateIcon,
                          eventDateOrTime:
                              AppLocalizations.of(context)!.event_Date,
                          chooseDateOrTime: selectedDate == null
                              ? AppLocalizations.of(context)!.choose_Date
                              : DateFormat('dd/MM/yyyy').format(selectedDate!),
                          //formatedDate,
                          onChooseDateOrTime: chooseDate),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      ChooseDateOrTime(
                          iconName: AssetsManager.timeIcon,
                          eventDateOrTime:
                              AppLocalizations.of(context)!.event_Time,
                          chooseDateOrTime: selectedTime == null
                              ? AppLocalizations.of(context)!.choose_Time
                              : formatedTime,
                          onChooseDateOrTime: chooseTime),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: AppStyles.medium16Black,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.008, horizontal: width * 0.02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.primaryLight, width: 2)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                  horizontal: width * 0.04),
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
                                AppLocalizations.of(context)!
                                    .choose_Event_Location,
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
                      CustomElevatedButton(
                          text: AppLocalizations.of(context)!.add_Event,
                          onButtonClicked: addEvent),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.now(),
    );
    selectedDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {});
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      Event event = Event(
        title: titleController.text,
        description: descriptionController.text,
        image: selectedImage,
        eventName: selectedEventName,
        dateTime: selectedDate!,
        time: formatedTime,
      );
      FirebaseUtils.addEventToFireStore(event, userProvider.currentUser!.id)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Event added successfully"),
            action: SnackBarAction(
              label: "ok",
              onPressed: () {},
            ),
          ),
        );
        eventListProvider.getAllEvents(userProvider.currentUser!.id);
      }).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Event added successfully"),
              action: SnackBarAction(
                label: "ok",
                onPressed: () {},
              ),
            ),
          );
          eventListProvider.getAllEvents(userProvider.currentUser!.id);
          Navigator.pop(context);
        },
      );
    }
  }
}
