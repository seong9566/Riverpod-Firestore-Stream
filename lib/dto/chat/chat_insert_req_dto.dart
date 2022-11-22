// FireStore에는 비정규 DB이기 때문에 Dto가 필수적임
// dart에서는 파일만 읽어도 내부에 모든 것들을 읽는다.
// java는 static가 붙은 것만 뜬다

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatInsertReqDto {
  String id;
  String from;
  String to;
  String msg;

  ChatInsertReqDto({required this.id, required this.from, required this.to, required this.msg});

  //dart -> map (toJson)
  // final doc = FirebaseFirestore.instance.collection('chat').doc();
  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "msg": msg,
      };

  //map -> dart (fromJson)
  factory ChatInsertReqDto.fromJson(Map<String, dynamic> json) => ChatInsertReqDto(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
      );
}

// class ChatDeleteReqDto(){
  
// }