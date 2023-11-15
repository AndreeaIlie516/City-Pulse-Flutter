import 'package:flutter/material.dart';
import 'event.dart';

class EventCellMain extends StatelessWidget {
  final Event event;
  final VoidCallback onClickEvent;
  final VoidCallback onClickFavoriteEvent;
  final bool isFavorite;

  const EventCellMain({
    Key? key,
    required this.event,
    required this.onClickEvent,
    required this.onClickFavoriteEvent,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
        child:InkWell(
            onTap: onClickEvent,

            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      event.imagePath,
                      width: 87,
                      height: 74,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event.time,
                            style: const TextStyle(
                              color: Color(0xff515BE9),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sf pro Display',
                            ),
                          ),
                          Text(
                            event.band,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sf pro Display',
                            ),
                          ),
                          Text(
                            event.location,
                            style: const TextStyle(
                              color: Color(0xff737373),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sf pro Display',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon:
                    Image.asset(
                      isFavorite ? 'assets/images/heart_full_red.png' : 'assets/images/heart_empty.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onPressed: onClickFavoriteEvent,
                  ),
                ],
              ),
            )
        )
    );
  }
}

class EventCellFavorite extends StatelessWidget {
  final Event event;
  final VoidCallback onClickEvent;
  final VoidCallback onClickUpdateEvent;
  final bool isEditable;

  const EventCellFavorite({
    Key? key,
    required this.event,
    required this.onClickEvent,
    required this.onClickUpdateEvent,
    this.isEditable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
        child:InkWell(
            onTap: onClickEvent,

            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      event.imagePath,
                      width: 87,
                      height: 74,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event.time,
                            style: const TextStyle(
                              color: Color(0xff515BE9),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sf pro Display',
                            ),
                          ),
                          Text(
                            event.band,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sf pro Display',
                            ),
                          ),
                          Text(
                            event.location,
                            style: const TextStyle(
                              color: Color(0xff737373),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sf pro Display',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: isEditable
                        ? Image.asset(
                            'assets/images/pen.png',
                            width: 25.0,
                            height: 25.0,
                          )
                        : const SizedBox.shrink(),
                    onPressed: isEditable ? onClickUpdateEvent : null,
                  ),
                ],
              ),
            )
        )
    );
  }
}
