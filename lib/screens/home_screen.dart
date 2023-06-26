import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/auth/api.dart';
import 'package:we_chat/constants.dart';
import 'package:we_chat/models/user.dart';
import 'package:we_chat/screens/profile.dart';
import 'package:we_chat/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    API.GetSelfInfo();
  }

  List<ChatUser> _dataList = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // to close the keyboard when user taps anywhere on the screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //if user is searching and presses back button then close the search bar
        // else close the app
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = false;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      letterSpacing: 0.5,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search name,email....',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        _searchList.clear();
                        for (var element in _dataList) {
                          if (element.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element.email
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                            _searchList.add(element);
                          }
                        }
                      });
                    },
                  )
                : const Text('Flash Chat'),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: Icon(
                  _isSearching ? CupertinoIcons.clear : CupertinoIcons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        User: API.me,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              right: 10,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
              elevation: 1,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                // Navigator.pop(context);
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
          body: StreamBuilder(
            stream: API.getAllUser(),
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
                  _dataList = docs
                      .map((e) => ChatUser.fromJson(e.data()))
                      .toList(); // .map is used to convert the list of documents to list of ChatUser objects
                  if (_dataList.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        top: mq.height * 0.012,
                      ),
                      itemCount:
                          _isSearching ? _searchList.length : _dataList.length,
                      // physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return UserCard(
                          User: _isSearching
                              ? _searchList[index]
                              : _dataList[index],
                        );
                        // return Text("Name: ${dataList[index]['name']}");
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No users found',
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
      ),
    );
  }
}
