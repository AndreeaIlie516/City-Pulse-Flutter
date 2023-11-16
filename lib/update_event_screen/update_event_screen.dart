import 'package:city_pulse/favorite_events_screen/favorite_events_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../event/event.dart';
import '../event/event_provider.dart';

class UpdateEventScreenView extends StatelessWidget {
  final int eventIndex;

  const UpdateEventScreenView({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteEventsScreenView()),
            );
          }),
          const SetScreenTitle(),
          Expanded(
            child: FieldList(eventIndex: eventIndex)
          )
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;

  const BackButton({Key? key, required this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(left: 24, top: 60.0),
      onPressed: onPressed,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.back,
            size: 20.0,
            color: Color(0xff515BE9)
          ),
          SizedBox(width: 4),
            Text(
              "Favorites",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xff515BE9)
              ),
            ),
          ],
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
          'Update Your Event:',
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

class FieldList extends StatelessWidget {
  final int eventIndex;

  FieldList({super.key, required this.eventIndex});

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _bandController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final eventModel = eventProvider.events[eventIndex];

    _timeController.text = eventModel.event.time;
    _bandController.text = eventModel.event.band;
    _locationController.text = eventModel.event.location;
    if(eventModel.event.imagePath != null) {
      _photoController.text = eventModel.event.imagePath!;
    } else {
      _photoController.text = '';
    }

    Widget textField(String label, TextEditingController controller) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: controller,
          cursorColor: const Color(0xff515BE9),
          decoration: InputDecoration(
              labelText: label,
              focusedBorder: const OutlineInputBorder( // Border color when the TextFormField is focused
                borderSide: BorderSide(color: Color(0xff515BE9)),
              ),
              labelStyle: const TextStyle(
                color: Colors.grey, // Default color
              ),
              // Changes label color when focused
              floatingLabelStyle: const TextStyle(
                color: Color(0xff515BE9),
              ),
          )
        ),
      );
    }

    Widget updateButton(BuildContext context, EventProvider eventProvider,
        int eventIndex) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff515BE9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            eventProvider.updateEvent(
                index: eventIndex,
                newEvent: Event(
                        time: _timeController.text,
                        band: _bandController.text,
                        location: _locationController.text,
                        imagePath: _photoController.text));
            eventProvider.notifyListeners();
            Navigator.of(context)
                .pop();
          },
          child: const Text(
            "Update Event",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sf pro Display',
            ),
          ),
        ),
      );
    }

    return ListView(
      children: [
        textField("Time", _timeController),
        textField("Band", _bandController),
        textField("Location", _locationController),
        textField(
            "Image URL (optional)", _photoController),
        updateButton(context, eventProvider, eventIndex),
      ],
    );
  }
}
