import 'package:blogexplorer/home_page/HomePage.dart';
import 'package:blogexplorer/home_page/splashscreen.dart';
import 'package:blogexplorer/widget/hive_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'api_provider/api_fetch.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(ItemAdapter());
  await initializeHive();
  runApp(
      ChangeNotifierProvider(
          create: (_)=>ApiProvider(),
          child: const MyApp()));
}
Future<void> initializeHive() async {
  await Hive.openBox<Item>('blogs');
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash(),
    );
  }
}

