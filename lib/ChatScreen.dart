import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'data_for_log_register/chatController.dart';

class ChatScreen extends StatefulWidget {
  final userName;

  const ChatScreen({Key key, this.userName}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  final chatController = Get.put(ChatController());

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser.uid);
    super.initState();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visions Support"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('messagesUser')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('msgs')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              List<DocumentSnapshot> items = snapshot.data.docs;
              var messages =
                  items.map((i) => ChatMessage.fromJson(i.data())).toList();
              return Obx(() => DashChat(
                    key: _chatViewKey,
                    inverted: false,
                    onSend: chatController.onSend,
                    sendOnEnter: true,
                    textInputAction: TextInputAction.send,
                    user: chatController.user.value,
                    inputDecoration: InputDecoration.collapsed(
                        hintText: "Add message here..."),
                    dateFormat: DateFormat('yyyy-MMM-dd'),
                    timeFormat: DateFormat('HH:mm'),
                    messages: messages,
                    showUserAvatar: false,
                    showAvatarForEveryMessage: false,
                    scrollToBottom: false,
                    onPressAvatar: (ChatUser user) {
                      print("OnPressAvatar: ${user.name}");
                    },
                    onLongPressAvatar: (ChatUser user) {
                      print("OnLongPressAvatar: ${user.name}");
                    },
                    inputMaxLines: 5,
                    messageContainerPadding:
                        EdgeInsets.only(left: 5.0, right: 5.0),
                    alwaysShowSend: true,
                    inputTextStyle: TextStyle(fontSize: 16.0),
                    inputContainerStyle: BoxDecoration(
                      border: Border.all(width: 0.0),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    onQuickReply: (Reply reply) {
                      setState(() {
                        messages.add(ChatMessage(
                            text: reply.value,
                            createdAt: DateTime.now(),
                            user: chatController.user.value));

                        messages = [...messages];
                      });

                      Timer(Duration(milliseconds: 300), () {
                        _chatViewKey.currentState.scrollController
                          ..animateTo(
                            _chatViewKey.currentState.scrollController.position
                                .maxScrollExtent,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );

                        if (i == 0) {
                          systemMessage();
                          Timer(Duration(milliseconds: 600), () {
                            systemMessage();
                          });
                        } else {
                          systemMessage();
                        }
                      });
                    },
                    onLoadEarlier: () {
                      print("laoding...");
                    },
                    shouldShowLoadEarlier: false,
                    showTraillingBeforeSend: true,
                    trailing: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.book_outlined,
                          semanticLabel: "Add document",
                        ),
                        onPressed: () async {
                          var result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowMultiple: false,
                              allowedExtensions: ['pdf', 'docx', 'doc']);

                          if (result != null) {
                            final Reference storageRef = FirebaseStorage
                                .instance
                                .ref()
                                .child("chat_images");

                            UploadTask uploadTask = storageRef.putFile(
                              File(result.paths[0]),
                              SettableMetadata(
                                contentType: 'document/pdf',
                              ),
                            );
                            TaskSnapshot download =
                                await uploadTask.whenComplete(() => null);

                            String url = await download.ref.getDownloadURL();

                            ChatMessage message = ChatMessage(
                                text: "",
                                user: chatController.user.value,
                                image: url);

                            var documentReference = FirebaseFirestore.instance
                                .collection('messagesUser')
                                .doc(FirebaseAuth.instance.currentUser.uid
                                    .toString())
                                .collection('msgs')
                                .doc(DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString());

                            FirebaseFirestore.instance
                                .runTransaction((transaction) async {
                              await transaction.set(
                                documentReference,
                                message.toJson(),
                              );
                            });
                          }
                        },
                      )
                    ],
                  ));
            }
          }),
    );
  }
}
