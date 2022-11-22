import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes_enum.dart';
import 'package:flutter_application_1/domain/chat/chat_firestore_repository.dart';
import 'package:flutter_application_1/dto/chat/chat_insert_req_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  return ChatController(ref); // ref가 필요해서 넘겨줌.
});

class ChatController {
  Ref _ref;
  ChatController(this._ref); //ref 사용하기 위함.

  void insert(ChatInsertReqDto dto) {
    Future<DocumentReference> futureDoc = _ref.read(chatFirestoreRepositoryProvider).insert(dto); // doc는 하나의 문서 docs는 여러개의 문서
    futureDoc.then((value) {
      print("document id : ${value.id}");
    }).onError((error, stackTrace) {
      print("error ${error}");
    });
    //db에서 1개의 정보에 연관된 정보가 모두 담겨져 있어서 한번에 찾아진다.
    //그래서 board에 comment를 찾고 싶다면 db.collection("comment"); 이렇게 하면 찾아진다. => 왜? doc는 한권의 문서와 같은 의미이다. 문서엔
    // 모든 데이터가 담겨져 있기 때문이다.
  }
}
