import 'dart:convert';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../widget/data_fetch.dart';
import '../widget/hive_data.dart';

class ApiProvider extends ChangeNotifier{
  List<Blog> _posts = [];
  List<Blog> get posts=>_posts;
  late Box<Item> _box;
  List<Item>itempro=[];
  String _res='error';
  String get res=>_res;
  ApiProvider() {
    _box = Hive.box<Item>('blogs');
  }

  List<Item>? get items => _box.values.toList();

  Future<void> fetchData() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        // print('u');
        final Map<String, dynamic> jsonData = json.decode(response.body);
        List jsonResponse =jsonData['blogs'];
        _posts= jsonResponse.map((data) => Blog.fromJson(data)).toList();

        itempro=jsonResponse.map((data) => Item.fromJson(data)).toList();
        if(_box.isEmpty){
          await _box.addAll(itempro);
        }
        // print('z');
        _res='sucess';
        notifyListeners();
      } else {
        // Request failed
        if (kDebugMode) {
          print('Request failed with status code: ${response.statusCode}');
        }
        _res='api_failed';
        notifyListeners();
        throw Exception(response.body);
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      // throw Exception('$e');
      if(e is SocketException){
        if ((e as SocketException).osError?.errorCode == 8) {
          if (kDebugMode) {
            print('***** Exception Caught ***** :$e');
          }
        }
        _res='os_failed';
        notifyListeners();
      }

    }
  }
  bool _check = true;
  bool get check=>_check;
  Future<void> internetcheck() async {
    _check = await InternetConnectionChecker().hasConnection;
    // if(_check == true) {
    //   print('YAY! Free cute dog pics!');
    //   print(InternetConnectionChecker().checkInterval);
    // } else {
    //   print('No internet :( Reason:');
    //   print(InternetConnectionChecker().checkTimeout);
    // }
    notifyListeners();
  }

  Future updateUser({required int index,required Item Itemmodel}) async {
    await _box.putAt(index,Itemmodel);
    notifyListeners();
  }

}