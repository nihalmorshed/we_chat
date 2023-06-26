import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/constants.dart';
import 'package:we_chat/models/user.dart';
import 'package:we_chat/screens/welcome_secondary.dart';
import 'package:we_chat/widgets/snackbar.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile-screen';
  final ChatUser User;
  ProfileScreen({required this.User});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //For hiding the keyboard when user taps on the screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.black,
            elevation: 1,
            onPressed: () async {
              SnackbarWidget.showProgressIndicator(context);
              await FirebaseAuth.instance.signOut().then((value) {
                GoogleSignIn().signOut().then((value) {
                  //For hiding the progress indicator
                  Navigator.pop(context);
                  //For poping the home screen and pushing the welcome screen
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, WelcomeSecondary.id);
                });
              });
            },
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mq.width * 0.05,
          ),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                SizedBox(
                  height: mq.height * .05,
                  width: mq
                      .width, // this line is aligning the whole column in center
                ),
                Stack(
                  children: [
                    //Profile Picture
                    CachedNetworkImage(
                      // imageUrl: widget.User.imageUrl,
                      imageUrl:
                          'https://media.istockphoto.com/id/846147812/photo/rainbow-lorikeet.jpg?s=1024x1024&w=is&k=20&c=rWz0KREDv2ihrPkwate0cLGR41zNs8jnpQ6lrWkQpqs=',
                      imageBuilder: (context, imageProvider) => Container(
                        width: mq.width * 0.4,
                        height: mq.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(mq.height * 0.3),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),

                    //Edit Profile Picture Button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MaterialButton(
                        color: Colors.white,
                        elevation: 1,
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mq.height * 0.04,
                ),
                Text(
                  widget.User.email,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.04,
                ),
                TextFormField(
                  initialValue: widget.User.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_4,
                      color: Colors.orangeAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    hintText: "eg. Mosleh Uddin",
                    label: Text("Name"),
                    labelStyle: TextStyle(
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.04,
                ),
                TextFormField(
                  initialValue: widget.User.about,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.orangeAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    hintText: "eg. Feeling Happy",
                    label: Text("About"),
                    labelStyle: TextStyle(
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.04,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.orange,
                    ),
                  ),
                  onPressed: () {},
                  label: const Text('Save'),
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
