// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta/model/create_model.dart';

class CreateSceen extends StatefulWidget {
  const CreateSceen({Key? key}) : super(key: key);

  @override
  State<CreateSceen> createState() => _CreateSceenState();
}

class _CreateSceenState extends State<CreateSceen> {
  final model = CreateModel();
  final _titleTextController = TextEditingController();
  File? _image;
  bool isLoading = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '새 게시물',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              if (_image != null && _titleTextController.text.isNotEmpty) {
                await model.uploadPost(_titleTextController.text, _image!);
              }
              if (mounted) Navigator.pop(context);
            },
            icon: Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titleTextController,
                decoration: InputDecoration(
                    hintText: '내용을 입력하세요',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                _image = await model.getImage();
                setState(() {});
              },
              child: Text('이미지 선택'),
            ),
            SizedBox(
              height: 20,
            ),
            if (_image != null)
              Image.file(
                _image!,
                width: 300,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
