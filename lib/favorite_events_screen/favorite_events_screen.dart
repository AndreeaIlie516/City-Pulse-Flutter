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

class EventList extends StatefulWidget {
  final EventProvider eventProvider;
  const EventList({super.key, required this.eventProvider});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  double swipeOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final favoriteEvents = widget.eventProvider.events.where((eventModel) => eventModel.isFavorite).toList();

    return ListView.builder(
      itemCount: favoriteEvents.length,
      itemBuilder: (context, index) {
        final originalIndex = widget.eventProvider.events.indexOf(favoriteEvents[index]);
        return
          Stack(
          children: [
            Positioned(
              left: swipeOffset,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 90,
                    color: const Color(0xffF95A5A),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'DELETE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sf pro Display',
                              ),
                            ),
                            IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset(
                                  'assets/images/bin.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                              onPressed: (){} ,
                            )
                          ]
                      )
                    ) // Your background color
                  ),
                ),
              ),
          ),
          Dismissible(
            key: Key(index.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              },
            background:Container(),
            child: EventCellFavorite(
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
                isPrivate: favoriteEvents[index].isPrivate
            ),
              confirmDismiss: (direction) async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return ShowConfirmationDialog(eventProvider: widget.eventProvider, originalIndex: originalIndex);
                  },
                );
                return result ?? false;
              }
        ),
        ]
        );
      },
    );
  }
}


class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sf pro Display',
            ),
          ),
        ),
      )
    );
  }
}

class ShowConfirmationDialog extends StatelessWidget {
  final EventProvider eventProvider;
  final int originalIndex;
  const ShowConfirmationDialog({super.key, required this.eventProvider, required this.originalIndex});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete Event",
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Are you sure you want to delete this item?",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                if(eventProvider.events[originalIndex].isPrivate) {
                  eventProvider.deleteEvent(index: originalIndex);
                } else {
                  eventProvider.deleteEventFromFavorites(index: originalIndex);
                }
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff515BE9),
              ),
              child: const Text(
                "Yes",
              ),
            ),
            const SizedBox(width: 80),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff515BE9),
              ),
              child: const Text(
                "No",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

