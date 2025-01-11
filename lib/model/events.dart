class Event {
  static const String collectionName = 'Event';

  String id;
  String title;
  String description;
  String image;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavourite;

  Event(
      {this.id = '',
      this.isFavourite = false,
      required this.title,
      required this.description,
      required this.image,
      required this.eventName,
      required this.dateTime,
      required this.time});

  //object=> json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'eventName': eventName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFavourite': isFavourite,
    };
  }

//json=> object
  Event.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            image: data['image'],
            eventName: data['eventName'],
            dateTime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
            time: data['time'],
            isFavourite: data['isFavourite']);
}
