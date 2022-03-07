import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse = '';
  List listResponse = [];
  Map mapResponse = {};
  Map dataResponse = {};
  Map dataResponseSupport = {};

  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users/2'));
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        dataResponse = mapResponse['data'];
        dataResponseSupport = mapResponse['support'];
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Center(child: Text('Api Demo')),
        titleSpacing: 1.5,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Center(
              child: Column(
                children: [
                  Image.network(dataResponse['avatar'].toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      '${dataResponse['first_name'].toString()} ${dataResponse['last_name'].toString()}',
                      style: const TextStyle(color: Colors.black)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(dataResponseSupport['text'].toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
