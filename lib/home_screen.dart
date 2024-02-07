import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_flutter_learning_7/Models/PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apis',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFE7B11B),
        appBar: AppBar(
          leading: const Icon(
            Icons.compare_arrows_rounded,
            color: Color(0xFFE7B11B),
          ),
          backgroundColor: Colors.black,
          title: const Text('Learning API'),
          titleTextStyle:
              const TextStyle(color: Color(0xFFE7B11B), fontSize: 24),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Loading...',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 16,)),
                        ],
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      elevation:
                                          0, // Adjust elevation as needed
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15.0), // Adjust border radius as needed
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15.0), // Same as shape's borderRadius
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(
                                                    0xFFFAEAFE), // Purple color
                                                Color(0xFFFFE48C),
                                                Color(
                                                    0xFFFEE068), // Purple color
                                                Color(0xFFEFE753),
                                                // Magenta color
                                              ], // Example colors
                                            ),
                                          ),
                                          //color: Colors.indigo.shade100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Post Id:' +
                                                          postList[index]
                                                              .id
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors
                                                              .blueAccent
                                                              .shade700),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text('Title: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors
                                                              .blueAccent
                                                              .shade400)),
                                                  Text(postList[index]
                                                      .title
                                                      .toString()),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text('Description:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors
                                                              .blueAccent
                                                              .shade400)),
                                                  Text(postList[index]
                                                      .body
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )));
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
      debugShowMaterialGrid: false,
    );
  }
}
