import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostsModel.dart';

class DropDownTesting extends StatefulWidget {
  const DropDownTesting({super.key});

  @override
  State<DropDownTesting> createState() => _DropDownTestingState();
}

class _DropDownTestingState extends State<DropDownTesting> {
  Future<List<PostsModel>> getpost() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return PostsModel(
            id: map['id'],
            userId: map['userId'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();
      }
    } on SocketException {
      throw Exception('No Internet');
    }
    throw Exception('Error fetching data');
  }

  var selectedIdValue, selectedTitleValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Testing Screen'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<PostsModel>>(
                future: getpost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        DropdownButton(
                            hint: const Text('Select Id...'),
                            value: selectedIdValue,
                            isExpanded: true,
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined),
                            items: snapshot.data!.map((e) {
                              return DropdownMenuItem(
                                  value: e.id.toString(),
                                  child: Text(e.id.toString()));
                            }).toList(),
                            onChanged: (value) {
                              selectedIdValue = value;
                              setState(() {});
                            }),
                        const SizedBox(height: 10),
                        DropdownButton(
                            hint: const Text('Select title...'),
                            value: selectedTitleValue,
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined),
                            isExpanded: true,
                            items: snapshot.data!.map((e) {
                              return DropdownMenuItem(
                                  value: e.title.toString(),
                                  child: Text(e.title.toString()));
                            }).toList(),
                            onChanged: (value) {
                              selectedTitleValue = value;
                              setState(() {});
                            })
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}
