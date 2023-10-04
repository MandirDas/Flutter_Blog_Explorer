import 'dart:convert';

import 'package:blogexplorer/api_provider/api_fetch.dart';
import 'package:blogexplorer/home_page/delait_blog_view.dart';
import 'package:blogexplorer/widget/data_fetch.dart';
import 'package:blogexplorer/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../widget/hive_data.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String x = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // internetcheck();
  }



  @override
  Widget build(BuildContext context) {
    // final itemsProvider = Provider.of<ApiProvider>(context);
    // itemsProvider.internetcheck();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        scrolledUnderElevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.white,
        title: const Text(
          'Blog View',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<ApiProvider>(builder: (context, ApiProvider, _) {
        ApiProvider.fetchData();
        ApiProvider.internetcheck();
        // ApiProvider.updateisliked();
        if (ApiProvider.items!.isEmpty || ApiProvider.res=='api_failed' || ApiProvider.res=='os_failed') {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: ApiProvider.items!.length,
              itemBuilder: (BuildContext context, int index) {
                var datas = ApiProvider.items![index];
                bool checker=ApiProvider.check;
                return Card(
                  color: Colors.white70,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      onTap: (){
                        // print(datas.title);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>detailBlogView(imageUrl: datas.image_url, id: datas.id, title: datas.title, isliked: datas.isliked, index: index,)));
                      },
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 170,
                            width: double.maxFinite,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: checker?Image.network(
                                datas.image_url,
                                scale: 1,
                                fit: BoxFit.cover,
                              ):Image.asset('assets/subspace_photo.png',color: Colors.black,),
                            )),
                      ),
                      subtitle: Row(
                        children: [
                          SizedBox(height: 10,),
                          Expanded(
                              flex: 4,
                              child: Text(datas.title)),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                print(datas.isliked);
                                ApiProvider.updateUser(index: index, Itemmodel: Item(title: datas.title, image_url: datas.image_url, id: datas.id,isliked:datas.isliked?false:true,));
                              },
                              child: datas.isliked?Icon(Icons.favorite):Icon(Icons.favorite_border),
                            ),
                          )
                        ],
                      ),
                      // leading: Text(snapshot.data![index].blogs[index].image_url),
                    ));
              }
          );
        }
      }),
    );
  }
}
