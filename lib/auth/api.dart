import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/models/user.dart';
import 'package:we_chat/models/messages.dart';

class API {
  static late ChatUser me;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

// useful for getting conversation id
  static String getConversationID(String id) =>
      auth.currentUser!.uid.hashCode <= id.hashCode
          ? '${auth.currentUser!.uid}_$id'
          : '${id}_${auth.currentUser!.uid}';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Messages message = Messages(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: FirebaseAuth.instance.currentUser!.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

//chats(collection) -> conversation_id(document) -> messages(collection) -> message(document)
//for sending message
  // static Future<void> sendMessage(ChatUser reciever, String msg) async {
  //   final time = DateTime.now().millisecondsSinceEpoch.toString();
  //   final ref = FirebaseFirestore.instance
  //       .collection('chats/${generateConversationId(reciever.id)}/messages');
  //   final message = Messages(
  //     toId: reciever.id,
  //     msg: msg,
  //     read: false.toString(),
  //     type: Type.text,
  //     sent: time,
  //     fromId: FirebaseAuth.instance.currentUser!.uid,
  //   );
  //   await ref.doc(time).set(message
  //       .toJson()); //chats(collection) -> conversation_id(document) -> messages(collection) -> time(document)
  // }

//for generating unique conversation id
  // static String generateConversationId(String id2) {
  //   String id1 = FirebaseAuth.instance.currentUser!.uid;
  //   if (id1.compareTo(id2) > 0) {
  //     return "${id1}_$id2"; // for example: 123_456 where 123 is the id of the current user and 456 is the id of the sender
  //   } else {
  //     return "${id2}_$id1"; //for example: 456_123 where 456 is the id of the sender and 123 is the id of the current user
  //   }
  // }

// users(collection) -> user_id(document) -> id(field)
//for getting user_id from firestore (ajaira , vule banaisi)
  // static Future<String> getConversationId(String id) async {
  //   String userId = "";
  //   await FirebaseFirestore.instance.collection("users").doc(id).get().then(
  //     (value) {
  //       if (value.exists) {
  //         userId = value.data()!['id'];
  //       }
  //     },
  //   );
  //   return userId;
  // }

//chats(collection) -> conversation_id(document) -> messages(collection) -> message(document)
//for getting all the messages from a specific id from firestore
  // static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
  //     ChatUser reciever) {
  //   return FirebaseFirestore.instance
  //       .collection('chats')
  //       .doc(generateConversationId(reciever.id))
  //       .collection("messages")
  //       .snapshots();
  // }

// For getting the current user info from the firestore
  static Future<void> GetSelfInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        me = ChatUser.fromJson(value.data()!);
      } else {
        await createUser().then((value) {
          GetSelfInfo();
        });
      }
    });
  }

  //For getting the users list from the firestore except the current user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //Checks if the user exists in the firestore or not
  static Future<bool> userExists() async {
    return (await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .exists;
  }

// Creates the user in the firestore
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final user = ChatUser(
      about: "about the past",
      name: FirebaseAuth.instance.currentUser!.displayName!.toString(),
      createdAt: time,
      lastActive: time,
      id: FirebaseAuth.instance.currentUser!.uid.toString(),
      isOnline: false,
      email: FirebaseAuth.instance.currentUser!.email!.toString(),
      pushToken: "",
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());
  }
}
