import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_feature_folder/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../../constants/constants.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String receiverEmail;
  final String receiverName;
  final String receiverPhoto;

  const ChatPage(
      {super.key,
      required this.receiverId,
      required this.receiverEmail,
      required this.receiverName,
      required this.receiverPhoto});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _massageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_massageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _massageController.text);
      _massageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff36B8B8),
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: Colors.white),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: widget.receiverPhoto == ''
                    ? const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.receiverPhoto),
                            fit: BoxFit.fill,
                          ),
                          shape: const OvalBorder(),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.receiverName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 320,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF9FFFF),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: _massageController,
                      decoration:  InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(GetImageEvent());
                          },
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10),
                        border: InputBorder.none,
                        hintText: 'Massage',
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      sendMessage();
                    },
                    backgroundColor: const Color(0xff36B8B8),
                    child: SvgPicture.asset(AppIcons.send),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessage(
          widget.receiverId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    Timestamp timestamp = data['timestamp'];
    var messageTime = DateTime.parse(timestamp.toDate().toString());
    String formattedDate = DateFormat('MMM d,h:mm a').format(messageTime);
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Padding(
      padding: (data['senderId'] == _firebaseAuth.currentUser!.uid)
          ? const EdgeInsets.only(left: 150, top: 10, right: 10)
          : const EdgeInsets.only(right: 150, top: 10, left: 10),
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            alignment: alignment,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (data['senderId'] == _firebaseAuth.currentUser!.uid
                  ? Colors.grey.shade200
                  : Colors.blue[200]),
            ),
            child: ListTile(
              title: Text(
                data['message'],
                style: const TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                formattedDate,
                style: const TextStyle(fontSize: 9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data['senderEmail'],
              style: const TextStyle(fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}
