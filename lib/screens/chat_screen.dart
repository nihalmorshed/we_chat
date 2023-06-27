import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/auth/api.dart';
import 'package:we_chat/constants.dart';
import 'package:we_chat/models/messages.dart';
import 'package:we_chat/models/user.dart';
import 'package:we_chat/widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  ChatScreen({required this.user});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //storing the list of messages
  List<Messages> _messageList = [];
  //handling the message typed by the user in the text field
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
        backgroundColor: const Color.fromARGB(255, 242, 215, 181),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: API.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final docs = snapshot.data!.docs;
                      _messageList = docs
                          .map((e) => Messages.fromJson(e.data()))
                          .toList(); // .map is used to convert the list of documents to list of ChatUser objects

                      if (_messageList.isNotEmpty) {
                        return ListView.builder(
                          padding: EdgeInsets.only(
                            top: mq.height * 0.012,
                          ),
                          itemCount: _messageList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MessageCard(
                              message: _messageList[index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'Say Hii!!  🖐 ',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }

  // Custom widget for chat input
  Widget _chatInput() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
          //emoji button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              color: Colors.orangeAccent,
            ),
          ),
          //text field
          Expanded(
            child: TextField(
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                hintStyle: TextStyle(
                  color: Colors.orangeAccent,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          //send button
          IconButton(
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                print(_messageController.text);
                API.sendMessage(
                  widget.user,
                  _messageController.text,
                  MsgType.text,
                );
                _messageController.clear();
              }
            },
            icon: const Icon(
              Icons.send,
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );
  }

  // Custom widget for appbar
  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          //back button
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          //profile picture
          CachedNetworkImage(
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
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          //space
          const SizedBox(
            width: 10.0,
          ),

          //name and status
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //show user name
              Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //space
              const SizedBox(
                height: 5.0,
              ),
              //user status
              Text(
                'Online',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
