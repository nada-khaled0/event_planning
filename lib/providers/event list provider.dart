import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/utils/toast.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/events.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  int selectedIndex = 0;
  List<Event> filterList = [];
  List<String> eventsNameList = [];

  void getEventsNameList(BuildContext context) {
    eventsNameList = [
      AppLocalizations.of(context)!.all,
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
  }

  List<Event> favEventList = [];

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .
            // orderBy('dateTime' ).
            get();
    eventList = querySnapshot.docs.map((docs) {
      return docs.data(); //to get data
    }).toList();
    filterList = eventList;

    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilteredEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .
            //orderBy('dateTime' ).
            // where('eventName', isEqualTo: eventsNameList[selectedIndex]).
            get();
    eventList = querySnapshot.docs.map((docs) {
      return docs.data(); //to get data
    }).toList();

    filterList = eventList.where((event) {
      return event.eventName == eventsNameList[selectedIndex];
    }).toList();

    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;

    if (selectedIndex == 0) {
      getAllEvents(uId);
    } else {
      getFilteredEvents(uId);
    }
  }

  void deleteEvent(String eventId, String uId) async {
    await FirebaseUtils.getEventCollection(uId).doc(eventId).delete();

    filterList.removeWhere((event) => event.id == eventId);

    selectedIndex == 0 ? getAllEvents(uId) : getFilteredEvents(uId);
    selectedIndex = 0;
    notifyListeners();
  }

  void updateFavouriteEvent(Event event, String uId) {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({'isFavourite': !event.isFavourite}).timeout(
            Duration(milliseconds: 500), onTimeout: () {
      ToastMessage.toastMsg(msg: 'Event updated successfully');
      selectedIndex == 0 ? getAllEvents(uId) : getFilteredEvents(uId);
      getFavouriteEvent(uId);
    });
    notifyListeners();
  }

  void getFavouriteEvent(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId)
        .orderBy('dateTime')
        .where('isFavourite', isEqualTo: true)
        .get();
    favEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    notifyListeners();
  }
}
