import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/chat_controller.dart';
import 'package:flutter_application_1/dto/chat/chat_insert_req_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRoomPage extends ConsumerWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.read(chatControllerProvider);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Random random = Random();
          ChatInsertReqDto dto = ChatInsertReqDto(from: "ssar", to: "cos", msg: "hello - ${random.nextInt(100)}");
          chatController.insert(dto);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: Text("msg : 안녕"),
              subtitle: Text("from : ssar"),
            ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: 2);
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("ChatRoomPage"),
    );
  }
}
