import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/constants.dart';
import 'package:we_chat/models/user.dart';
import 'package:we_chat/screens/chat_screen.dart';

class UserCard extends StatefulWidget {
  ChatUser User;
  UserCard({required this.User});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[50],
      elevation: 1,
      margin: EdgeInsets.symmetric(
        vertical: mq.height * 0.01,
        horizontal: mq.width * 0.02,
      ),
      child: InkWell(
        onTap: () {
          //for navigating to chat screen
          // Navigator.pushNamed(context, ChatScreen.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                user: widget.User,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CachedNetworkImage(
            // imageUrl: widget.User.imageUrl,
            imageUrl:
                'https://media.istockphoto.com/id/846147812/photo/rainbow-lorikeet.jpg?s=1024x1024&w=is&k=20&c=rWz0KREDv2ihrPkwate0cLGR41zNs8jnpQ6lrWkQpqs=',
            imageBuilder: (context, imageProvider) => Container(
              width: mq.width * 0.1,
              height: mq.height * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          title: Text(
            widget.User.name,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.User.about,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black45,
            ),
          ),
          trailing: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
