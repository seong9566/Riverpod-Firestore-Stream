import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/dto/chat/chat_insert_req_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatFirestoreRepositoryProvider = Provider((ref) {
  // FireStore를 창고에 넣음.
  return ChatFirestoreRepository();
});

class ChatFirestoreRepository {
  final db = FirebaseFirestore.instance;

  // 책임을 부여
  Future<DocumentReference> insert(ChatInsertReqDto dto) {
    return db.collection("chat").add(dto.toJson());
  }
}
