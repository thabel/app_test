import 'package:flutter/material.dart';

  final List<int> myList = List<int>.generate(100, (i) => i);

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // ✅ FIXED
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const MyTestWidget(),
            const SizedBox(height: 20),
            const RowOfProfiles(),
            const MyTestAgain(),
            const MyListBuilder()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyListBuilder extends StatelessWidget {

  const MyListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Set a fixed height for the ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: myList.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.all(8.0),
            color: Colors.blue[(index % 9 + 1) * 100],
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
class MyTestAgain extends StatelessWidget {
  const MyTestAgain({super.key});

  @override
  Widget build(BuildContext context) {
    return  
Text("Hello");



  }
}

class RowOfProfiles extends StatelessWidget {
  const RowOfProfiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [

        CircleAvatar(
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1514377006585-6e7975371bd6?w=400&h=400&fit=crop'),
         
        ),
        SizedBox(width: 10),
        CircleAvatar(
          backgroundImage: NetworkImage('https://example.com/profile2.jpg'),
        ),
        SizedBox(width: 10),
        CircleAvatar(
          backgroundImage: NetworkImage('https://example.com/profile3.jpg'),
        ),
      ],
    );
  }
}
class MyTestWidget extends StatelessWidget {
  const MyTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'This is a custom widget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text('What does Column actually mean?'),
      ],
    );
  }
}
