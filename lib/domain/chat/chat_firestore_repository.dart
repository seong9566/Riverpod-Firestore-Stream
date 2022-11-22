import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/domain/chat/chat.dart';
import 'package:flutter_application_1/dto/chat/chat_insert_req_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//리턴 : Stream<List<Chat>>
final chatStreamProvider = StreamProvider.autoDispose<List<Chat>>((ref) {
  // autoDispose화면 전환시 메모리에 떠있는것을 죽임, 전역적인 부분은 autoDispose를 걸지말자. stream이 달려있는 곳에선 왠만하면 걸어준다.
  ref.onDispose(() {}); //Provider이 메모리에서 죽을때 데이터를 관리 할 수 있는 방법
  ref.onResume(() {}); // 앱을 사용하다가 다른 앱을 사용하고 다시 돌아왔을때 다시 메모리에 띄어줌.
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection("chat").snapshots(); //리턴 타입을 정확하게 적어줄 필요가 있음 왜? 파싱을 위해서
// 스트림으로 받았으니 이제 파싱이 필요함.

  /**아래 코드 해석
   * stream을 그냥 리턴을 해주면 stream의 map의 dynamic을 주게 된다. 그럼 view에서 파싱을 해주게 된다.
   * view에서 파싱을 하게 되면 굉장히 복잡해진다. 
   * stream의 map을 snapshot로 잘개 쪼개면 docs(문서들)로 된다. 이 값들을 또 다시 쪼개서 fromJson으로 바꾸어서 쪼개진 값들을 toList로 바꾸어 리턴해준다.
   */
  return stream.map((snapshot) => snapshot.docs.map((doc) => Chat.fromJson(doc.data(), id: doc.id)).toList()); //파싱
});

final chatFirestoreRepositoryProvider = Provider((ref) {
  // FireStore를 창고에 넣음.
  return ChatFirestoreRepository();
});

//Repository의 역할 : 통신 및 파싱 역할
class ChatFirestoreRepository {
  final db = FirebaseFirestore.instance; // 싱글톤 객체

  // 책임을 부여
  Future<DocumentReference> insert(ChatInsertReqDto dto) {
    return db.collection("chat").add(dto.toJson());
  }

  //findAllStream은 지속적으로 읽기
  // Stream findAllStream() {
  //   //db.collection("chat").orderBy("createdAt").snapshots();
  //   //spring는 http정책을 따라 요청하고 응답이 끝나면 연결을 끊는다
  //   // shapshots의 리턴 타입이 Stream이라는 뜻은 FireStore는 서버자체가 만들어질때 응답은 끊지 않고 계속 유지 하고 있단 말이다.
  //   return db.collection("chat").snapshots();
  // }
}
