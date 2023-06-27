// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/model/acocount_model.dart';

import '../domain/post.dart';
import 'detail_post_sceen.dart';

class AccountSceen extends StatelessWidget {
  final model = AccounModel();
  AccountSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instagram Clon',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              model.logout();
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.black,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(model.getProfileImageUrl()),
                          radius: 40,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      model.getNickName(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: [
                    StreamBuilder<QuerySnapshot<Post>>(
                        stream: model.postsStream,
                        builder: (context, snapshot) {
                          int count = 0;
                          if (snapshot.hasData) {
                            count = snapshot.data!.size;
                          }
                          return Text(
                            '$count',
                            style: TextStyle(fontSize: 18),
                          );
                        }),
                    Text(
                      '게시물',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '팔로워',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '팔로잉',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
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
          ),
        ],
      ),
    );
  }
}
