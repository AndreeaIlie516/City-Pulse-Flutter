import 'package:flutter/cupertino.dart';

import 'event.dart';

class EventProvider with ChangeNotifier {
  final List<EventModel> _events = [
    EventModel(
        event: Event(time: '27 Oct - 19:30', band: 'Coma + Om la Lună', location: 'Zazen Garden', imagePath: 'assets/images/first_event_photo.png'),
        isFavorite: false,
        isPrivate: false
    ),
    EventModel(
        event: Event(time: '04 Nov - 21:30', band: 'Vama', location: '/FORM SPACE', imagePath: 'assets/images/second_event_photo.png'),
        isFavorite: false,
        isPrivate: false
    ),
    EventModel(
        event: Event(time: '11 Nov - 21:00', band: 'Stratovarius\nSonata Arctica', location: '/FORM SPACE', imagePath: 'assets/images/third_event_photo.jpg'),
        isFavorite: false,
        isPrivate: false
    ),
    EventModel(
        event: Event(time: '06 Dec - 21:00', band: 'Asaf Avidan', location: '/FORM SPACE', imagePath: 'assets/images/forth_event_photo.jpg'),
        isFavorite: false,
        isPrivate: false
    ),
    EventModel(
        event: Event(time: '07 Dec - 20:30', band: 'Tarja', location: '/FORM SPACE', imagePath: 'assets/images/fifth_event_photo.jpg'),
        isFavorite: false,
        isPrivate: false
    ),
    EventModel(
        event: Event(time: '27 Feb - 18:00', band: 'Cradle of Filth', location: '/FORM SPACE', imagePath: 'assets/images/sixth_event_photo.jpg'),
        isFavorite: false,
        isPrivate: false
    ),

  ];

  List<EventModel> get events => _events;

  void toggleFavoriteStatus(int index) {
    _events[index].isFavorite = !_events[index].isFavorite;
    notifyListeners();
  }

  void addEvent({required Event newEvent}) {
    _events.add(EventModel(
      event: newEvent,
      isFavorite: true,
      isPrivate: true
    ));
    notifyListeners();
  }

  void updateEvent({required int index, required Event newEvent}) {
    if(index >= 0 && index <_events.length) {
      _events[index] = EventModel(
        event: newEvent,
        isFavorite: _events[index].isFavorite,
        isPrivate: _events[index].isPrivate,
      );
    }
  }

  void deleteEventFromFavorites({required int index}) {
    if (index >= 0 && index < _events.length) {
      _events[index].isFavorite = false;
      notifyListeners();
    }
  }

  void deleteEvent({required int index}) {
    if (index >= 0 && index < _events.length) {
      _events.removeAt(index);
      notifyListeners();
    }
  }

}