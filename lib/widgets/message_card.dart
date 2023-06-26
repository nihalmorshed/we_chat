import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/constants.dart';
import 'package:we_chat/models/messages.dart';

class MessageCard extends StatefulWidget {
  final Messages message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.uid == widget.message.fromId
        ? _blueMessage()
        : _greenMessage();
  }

  //senders message
  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //showing the sender's message content
        Flexible(
          //wrap with flexible to avoid overflow and make the message box responsive
          child: Container(
            padding: EdgeInsets.all(mq.width * 0.04),
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * 0.02,
              vertical: mq.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.indigo[100],
              border: Border.all(
                color: Colors.blue,
              ),
              //making the message box round in three corners
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
              ),
            ),
            child: Text(
              "${widget.message.msg} ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),

        //show the time when the message was sent
        Padding(
          padding: EdgeInsets.only(right: mq.width * 0.02),
          child: Text(
            widget.message.sent,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }

  //users message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //show the time when the message was read
        Row(
          children: [
            //showing the double tick icon for seen messages
            Padding(
              padding: EdgeInsets.only(
                left: mq.width * 0.02,
              ),
              child: const Icon(
                Icons.done_all,
                color: Colors.grey,
                size: 20.0,
              ),
            ),

            //showing the time when the message was seen
            Text(
              widget.message.read,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),

        //showing the user's message content
        Flexible(
          //wrap with flexible to avoid overflow and make the message box responsive
          child: Container(
            padding: EdgeInsets.all(mq.width * 0.04),
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * 0.02,
              vertical: mq.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.green[200],
              border: Border.all(
                color: Colors.green,
              ),
              //making the message box round in three corners
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Text(
              "${widget.message.msg} ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
