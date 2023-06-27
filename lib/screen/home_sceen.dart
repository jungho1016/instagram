// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/model/home_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;

  final model = HomeModel();

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
      ),
      body: Column(
        children: [
          Text(
            'Instagram에 오신 것을 환영합니다',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '사진과 동영상을 보려면 팔로우 하세요',
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              elevation: 4.0,
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () async {
                      await model.updateProfileImage();
                      setState(() {});
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://t1.daumcdn.net/cfile/tistory/99D1E93D5E0F738C39',
                      ),
                      radius: 40,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    model.getEmail(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    model.getNickName(),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd_Zyni1nf_tjISPSIj3jLUgmaIn1Ta5Nvrw&usqp=CAU',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHKoKklc9y-I9gC1P8oqJ-lHI3wchOKu7Gww&usqp=CAU',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Image.network(
                        'https://isplus.com/data/isp/image/2021/11/25/ispfb815c77-ed68-40ee-9e43-4e6c3de3bf12.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'FaceBook 친구',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('팔로우'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
