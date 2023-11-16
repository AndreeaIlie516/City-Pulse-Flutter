import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_event_screen/add_event_screen.dart';
import '../event/event_cell.dart';
import '../event/event_provider.dart';
import '../update_event_screen/update_event_screen.dart';


class FavoriteEventsScreenView extends StatelessWidget {
  const FavoriteEventsScreenView({super.key});

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
          const AddButton()
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
          'Your Favorite Events:',
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
    final favoriteEvents = eventProvider.events.where((eventModel) => eventModel.isFavorite).toList();

    return ListView.builder(
      itemCount: favoriteEvents.length,
      itemBuilder: (context, index) {
        final originalIndex = eventProvider.events.indexOf(favoriteEvents[index]);

        return EventCellFavorite(
            event: favoriteEvents[index].event,
            onClickEvent: () {  },
            onClickUpdateEvent: () {
              if(originalIndex != -1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      UpdateEventScreenView(eventIndex: originalIndex)),
                );
              }
            },
            isPrivate: favoriteEvents[index].isPrivate);
      },
    );
  }
}


class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: Align(
        alignment: Alignment.centerRight,
        child:ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff515BE9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fixedSize: const Size(50.0, 50.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddEventScreenView()),
            );
          },
          child: const Text(
            "+",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sf pro Display',
            ),
          ),
        ),
      )
    );
  }
}


