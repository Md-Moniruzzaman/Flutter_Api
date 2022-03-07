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

  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
        // dataResponseSupport = mapResponse['support'];
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
      body: ListView.builder(
        itemCount: listResponse.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(listResponse[index]['avatar'].toString()),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  '${listResponse[index]['first_name'].toString()} ${listResponse[index]['last_name'].toString()}',
                  style: const TextStyle(color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              Text(listResponse[index]['email'].toString()),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
