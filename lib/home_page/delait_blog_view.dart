import 'package:blogexplorer/Description_ex/description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api_provider/api_fetch.dart';
import '../widget/hive_data.dart';

class detailBlogView extends StatefulWidget {
  final String imageUrl;
  final String id;
  final String title;
  final bool isliked;
  final int index;
  const detailBlogView({super.key, required this.imageUrl, required this.id, required this.title, required this.isliked, required this.index});

  @override
  State<detailBlogView> createState() => _detailBlogViewState();
}

class _detailBlogViewState extends State<detailBlogView> {
  @override
  Widget build(BuildContext context) {
    // bool isLiked=widget.isliked;
    var dt = DateTime.now();
    // final itemsProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Detailed Blog View',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ApiProvider>(
            builder: (context, ApiProvider, _) {
              // ApiProvider.fetchData();
              // ApiProvider.internetcheck();
              bool checker=ApiProvider.check;
              var datas=ApiProvider.items![widget.index];
            return ListView(
              // shrinkWrap: true,
              children: [
                Text(widget.title,textAlign: TextAlign.left,style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),),
                SizedBox(height: 10,),
                Container(
                    height: 180,
                    width: double.maxFinite,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: checker?Image.network(
                        widget.imageUrl,
                        scale: 1,
                        fit: BoxFit.cover,
                      ):Image.asset('assets/subspace_photo.png',color: Colors.black,),
                    )),
                SizedBox(height: 10,),

                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Text('${dt.year}/${dt.month}/${dt.day}',style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),)),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          ApiProvider.updateUser(index: widget.index, Itemmodel: Item(title: widget.title, image_url: widget.imageUrl, id: widget.id,isliked:datas.isliked?false:true,));
                          print(datas.isliked);
                          },
                        child: datas.isliked?Icon(Icons.favorite):Icon(Icons.favorite_border)),)
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(document().doc1()),
                ),
                // AnimatedIcon(icon: AnimatedIcons., progress: progress)

              ],
            );
          }
        ),
      ),
    );
  }
}
