import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/pages/chat_room/chat_room_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main메서드에 비동기 작업이 있으면 꼭 필요함.
  await Firebase.initializeApp(
    // 안드로이드와 아이폰과 통신을 실행부분
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatRoomPage(),
    );
  }
}
