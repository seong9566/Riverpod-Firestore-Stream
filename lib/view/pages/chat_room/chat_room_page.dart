import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/chat_controller.dart';
import 'package:flutter_application_1/domain/chat/chat_firestore_repository.dart';
import 'package:flutter_application_1/dto/chat/chat_insert_req_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRoomPage extends ConsumerWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.read(chatControllerProvider);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListView(ref),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Random random = Random();
          ChatInsertReqDto dto = ChatInsertReqDto(id: "id", from: "ssar", to: "cos", msg: "hello - ${random.nextInt(100)}");
          chatController.insert(dto);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(WidgetRef ref) {
    final chatStream = ref.watch(chatStreamProvider);
    return chatStream.when(
      data: (chats) {
        if (chats.isNotEmpty) {
          return ListView.separated(
            itemCount: chats.length,
            itemBuilder: (context, index) => ListTile(
              title: Text("msg : ${chats[index].msg}"),
              subtitle: Text("from : ${chats[index].from}"),
            ),
            separatorBuilder: (context, index) => Divider(),
          );
        } else {
          return Center(
            child: Text("채팅 내역 없음", style: TextStyle(fontSize: 50)),
          );
        }
      },
      error: (error, stackTrace) => CircularProgressIndicator(),
      loading: () => CircularProgressIndicator(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("ChatRoomPage"),
    );
  }
}
