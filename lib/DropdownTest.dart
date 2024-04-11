import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



import 'Models/PostsModel.dart';class DropDownTesting extends StatefulWidget {
  const DropDownTesting({super.key});

  @override
  State<DropDownTesting> createState() => _DropDownTestingState();
}

class _DropDownTestingState extends State<DropDownTesting> {

  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
