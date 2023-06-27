// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/model/search_model.dart';
import 'package:insta/screen/create_screen.dart';
import 'package:insta/screen/detail_post_sceen.dart';

import '../domain/post.dart';

class SearchSceen extends StatelessWidget {
  final List<String> _urls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3JEhFiOrm2CuIWf5TMB6_m1zBSGOCifs2Bw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqRc5Te77rDosCRQfPB1OomnBk7eYgGF5pNQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPfLJh3Kuz4ut9Ngbf9UrjGwBxZlaNMpo5EA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThWerfLUntZ5bWIilgzRTx8TDtkz8AQBpMRg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHKoKklc9y-I9gC1P8oqJ-lHI3wchOKu7Gww&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7x6KI_lsCLhXiJTswuuu5D6soKTydg3eBFA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmz13CYsvNL9y1k-ieRJ59gdk-gxbCwclKzQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD2nDKffIQem6X_fZYhzjMx55F17DYOZsjeA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOsxZRhm72Oh4tPc-srr4YSGa71VL46J_37w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd_Zyni1nf_tjISPSIj3jLUgmaIn1Ta5Nvrw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHKoKklc9y-I9gC1P8oqJ-lHI3wchOKu7Gww&usqp=CAU',
    'https://isplus.com/data/isp/image/2021/11/25/ispfb815c77-ed68-40ee-9e43-4e6c3de3bf12.jpg',
  ];
  SearchSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = SearchModel();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instagram Clon',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Post>>(
            stream: model.postsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('알수 없는 에러');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('로딩중');
              }

              List<Post> posts =
                  snapshot.data!.docs.map((e) => e.data()).toList();

              return GridView.builder(
                itemCount: posts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 3),
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (DetailPostSceen(
                            post: post,
                          )),
                        ),
                      );
                    },
                    child: Hero(
                      tag: post.id,
                      child: Image.network(
                        post.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateSceen()),
          );
        },
        child: Icon(Icons.create),
      ),
    );
  }
}
