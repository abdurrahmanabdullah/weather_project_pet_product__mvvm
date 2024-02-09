import 'package:flutter/material.dart';

class ListSearch extends StatefulWidget {
  const ListSearch({super.key});

  @override
  State<ListSearch> createState() => _ListSearchState();
}

class _ListSearchState extends State<ListSearch> {
  List<Map<String, dynamic>> alluser = [
    {"id": 1, "name": "abdullah", "age": 23},
    {"id": 2, "name": "abrar", "age": 23},
    {"id": 3, "name": "anar", "age": 23},
    {"id": 4, "name": "bbdullah", "age": 33},
    {"id": 5, "name": "cbdullah", "age": 43},
    {"id": 6, "name": "dbdullah", "age": 53}
  ];
  List<Map<String, dynamic>> foundUsers = [];
  @override
  void initState() {
    foundUsers = alluser;
    super.initState();
  }

  void runfilter(String value) {
    if (value.isEmpty) {
      foundUsers = alluser;
    } else {
      foundUsers = alluser
          .where((element) =>
              element['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("list search")),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              runfilter(value);
            },
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                labelText: 'search', suffixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: foundUsers.length,
                itemBuilder: (context, index) {
                  return Card(
                      key: ValueKey(foundUsers[index]['id']),
                      child: ListTile(
                        leading: Text(foundUsers[index]['id'].toString()),
                        title: Text(
                          foundUsers[index]['name'].toString(),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
