import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/model/events.dart';
import 'package:event_planning/model/my%20user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, option) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, _) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    CollectionReference<Event> collectionRef =
        getEventCollection(uId); //created collection
    DocumentReference<Event> docRef = collectionRef.doc(); // created document
    event.id = docRef.id;
    return docRef.set(event);
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, _) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (user, _) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUserCollection().doc(id).get();
    return querySnapshot.data();
  }
}
