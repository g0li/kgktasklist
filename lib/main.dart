import 'package:flutter/material.dart';
import 'package:kgktasklist/items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addItemm(),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: <Widget>[
          TextFormField(
            controller: inputController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(hintText: 'Enter Item'),
            onFieldSubmitted: (_) => addItemm(),
          ),
          Text(list
              .map((e) => e.index.toString())
              .toList()
              .toString()), // added thhis to visualise implementation
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                reverse: true,
                itemBuilder: (context, index) => _ItemWidget(
                      item: list[index],
                      onTap: (_) {
                        updateItem(index, _);
                      },
                    )),
          )
        ],
      ),
    );
  }

  void addItemm() {
    setState(() {
      list.add(Item(
          index: list.length + 1,
          name: inputController.text,
          isCompleted: false));
      inputController.clear();
    });
  }

  void updateItem(int position, bool _) {
    return setState(() {
      list[position].isCompleted = _;
      list[position].index = position;

      if (_) {
        list.sort((a, b) => b.isCompleted ? 1 : -1);
      }
    });
  }

  TextEditingController inputController = TextEditingController();
  List<Item> list = [];
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.item, required this.onTap});
  final Item item;
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        item.name,
        style: TextStyle(
            decoration: item.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) => onTap(value!),
      value: item.isCompleted,
    );
  }
}
