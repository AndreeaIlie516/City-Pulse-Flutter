import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../event/event_cell.dart';
import '../event/event_provider.dart';


class PopularEventsScreenView extends StatelessWidget {
  const PopularEventsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SetTitle(),
          const SetScreenTitle(),
          Expanded(
            child: Consumer<EventProvider>(
              builder: (context, eventProvider, child) {
                return EventList(eventProvider: eventProvider);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SetTitle extends StatelessWidget {
  const SetTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24, top: 60.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'CityPulse',
          style: TextStyle(
            color: Color(0xff515BE9),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sf pro Display',
          ),
        ),
      ),
    );
  }
}

class SetScreenTitle extends StatelessWidget {
  const SetScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24.0, top: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Popular Events',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sf pro Display',
          ),
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  final EventProvider eventProvider;
  const EventList({super.key, required this.eventProvider});

  @override
  Widget build(BuildContext context) {
    final events = eventProvider.events.where((eventModel) => !eventModel.isPrivate).toList();
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCellMain(
            event: events[index].event,
            onClickEvent: () {  },
            onClickFavoriteEvent: () { eventProvider.toggleFavoriteStatus(index); },
            isFavorite: eventProvider.events[index].isFavorite);
      },
    );
  }
}
