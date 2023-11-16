class Event {
  late final String time;
  late final String band;
  late final String location;
  late final String? imagePath;

  Event({required this.time, required this.band, required this.location, required this.imagePath});
}

class EventModel {
  final Event event;
  bool isFavorite;
  bool isPrivate;

  EventModel({required this.event, this.isFavorite = false, this.isPrivate = true});
}