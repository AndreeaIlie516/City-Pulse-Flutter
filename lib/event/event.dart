class Event {
  final String time;
  final String band;
  final String location;
  final String imagePath;

  Event({required this.time, required this.band, required this.location, required this.imagePath});
}

class EventModel {
  final Event event;
  bool isFavorite;
  bool isEditable;

  EventModel({required this.event, this.isFavorite = false, this.isEditable = true});
}