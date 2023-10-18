import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../chat/presentation/pages/chat_page/chat_page.dart';
import '../../../../main/presentation/bloc/main_bloc.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  User? user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: const Color(0xff36B8B8),
            centerTitle: true,
            title: const Text('Chats'),
            elevation: 0,
          ),
          body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('emailUsers')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if ((snapshot.data?.docs.length ?? 0) > 0) {
                    return ListView(
                      children: snapshot.data!.docs
                          .map<Widget>((doc) => _buildUserListItem(doc))
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text("No users"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (user?.uid == document.id) {
      return const SizedBox.shrink();
    } else {
      return ListTile(
          title: Text(data['name']),
          subtitle: Text(data['email']),
          leading: data['photo'] == null
              ? const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 30,color: Colors.white,),
          )
              : CircleAvatar(
                  backgroundImage: NetworkImage(data['photo']),
                ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    receiverId: data['uid'],
                    receiverEmail: data['email'],
                    receiverName: data['name'],
                    receiverPhoto: data['photo'] ?? ''),
              ),
            );
          });
    }
  }
}
