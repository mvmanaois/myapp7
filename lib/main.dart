import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  State<ItemListScreen> createState() => ItemListState();
}

class ItemListState extends State<ItemListScreen> {
  final List<String> itemList = [];
  List<String> filteredList = [];

  void addItem(String newItem) {
    setState(() {
      itemList.add(newItem);
      filteredList.add(newItem);
    });
  }

  void removeItem(int index) {
    setState(() {
      itemList.removeAt(index);
      filteredList.removeAt(index);
    });
  }

  void filterItems(String query) {
    setState(() {
      filteredList = itemList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('QUIZ', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String input = '';
                  return AlertDialog(
                    backgroundColor: Colors.blueGrey.shade800,
                    title: Text('Add Item', style: TextStyle(color: Colors.white)),
                    content: TextField(
                      onChanged: (value) {
                        input = value;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter item name',
                        hintStyle: TextStyle(color: Colors.white60),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel', style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          if (input.isNotEmpty) {
                            addItem(input);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('Add', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: filterItems,
              decoration: InputDecoration(
                labelText: 'Search Items',
                labelStyle: TextStyle(color: Colors.blueGrey.shade700),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(filteredList[index]),
                  onDismissed: (direction) {
                    removeItem(index);
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 6,
                    child: ListTile(
                      title: Text(
                        filteredList[index],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
