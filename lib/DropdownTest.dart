import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



import 'Models/PostsModel.dart';class DropDownTesting extends StatefulWidget {
  const DropDownTesting({super.key});

  @override
  State<DropDownTesting> createState() => _DropDownTestingState();
}

class _DropDownTestingState extends State<DropDownTesting> {

  Future<List<PostsModel>> getpost() async{
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final body = json.decode(response.body) as List;

      if(response.statusCode == 200){
        return body.map((e){
          final map = e as Map<String, dynamic>;
          return PostsModel(
            id: map['id'],
            userId: map['userId'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();
      }
    }
    on SocketException{
      throw Exception('No Internet');
    }
    throw Exception('Error fetching data');
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}



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
