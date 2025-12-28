import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_model.dart';
import 'counter_bloc.dart';
import 'info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Provider state manager")),
        body: Column(
          children: [
            ChangeNotifierProvider(
              create: (context) => CounterModel(),

              child: DemoPage(),
            ),
            ChangeNotifierProvider(
              create: (context) => Info(),
              child: InfoWidget(),
            ),
            BlocProvider(
              create: (context) => CounterBloc(),
              child: ALphabetChanger(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final info = context.watch<Info>();
    return Column(
      children: [
        Text(
          info.getText(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: info.change,
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(12),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          child: const Text("Change Text"),
        ),
      ],
    );
  }
}

class ALphabetChanger extends StatelessWidget {
  const ALphabetChanger({super.key});

  void onPressed() {}
  @override
  Widget build(BuildContext context) {
    final blockstate = context.watch<CounterBloc>();
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Letter', style: TextStyle(fontSize: 20)),
          Text(
            String.fromCharCode(blockstate.state),
            style: TextStyle(fontSize: 20),
          ),
          Text('order', style: TextStyle(fontSize: 20)),
          Text("${blockstate.state}", style: TextStyle(fontSize: 20)),
          TextButton(
            onPressed: () => blockstate.add(CounterIncrementPressed()),

            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.all(12),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: Text("Next", style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: counter.increment,
          child: Icon(Icons.add, color: Colors.green),
        ),

        Text(
          "${counter.counter}",
          style: TextStyle(color: Colors.black45, fontSize: 30),
        ),
        TextButton(
          onPressed: counter.decrement,
          child: Icon(Icons.remove, color: Colors.red),
        ),
      ],
    );
  }
}

class ProviderDescriptionWidget extends StatelessWidget {
  const ProviderDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      Icon(
                        Icons.layers_outlined,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Why Provider?',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const _BulletPoint(
                    text: 'Simplified allocation and disposal of resources',
                  ),
                  const _BulletPoint(
                    text: 'Lazy-loading of objects only when needed',
                  ),
                  const _BulletPoint(
                    text:
                        'Vastly reduced boilerplate compared to writing a new InheritedWidget each time',
                  ),
                  const _BulletPoint(
                    text:
                        'DevTools friendly — application state is visible in Flutter DevTools',
                  ),
                  const _BulletPoint(
                    text:
                        'Common and consistent consumption patterns (Provider.of, Consumer, Selector)',
                  ),
                  const _BulletPoint(
                    text:
                        'Improved scalability for listener-based classes like ChangeNotifier '
                        '(O(N) notification dispatch)',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

// class _DemoPageState extends State<DemoPage> {
//   int _counter = 0;
//   void  _increment_counter(){
//     setState(() {
//       _counter++;
//     });
//   }

//   void _decrement_counter(){
//     setState(() {
//       _counter -- ;
//     });
//   }
//  @override
// Widget build(BuildContext context) {
//   return Scaffold( // <--- Wrap your Row in a Scaffold
//     body: Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           TextButton(onPressed: _increment_counter, child: Icon(Icons.add, color: Colors.green)),
//           Text("$_counter", style: TextStyle(color: Colors.black45, fontSize: 30)),
//           TextButton(onPressed: _decrement_counter, child: Icon(Icons.remove, color: Colors.red)),
//         ],
//       ),
//     ),
//   );
// }
// }

class MyLayoutBuilderExperience extends StatelessWidget {
  const MyLayoutBuilderExperience({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return ListData();
          }
          return GridData();
        },
      ),
    );
  }
}

class GridData extends StatelessWidget {
  const GridData({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(100, (index) {
        return Center(
          child: ListTile(
            leading: const Icon(Icons.add_box),
            title: Text("Item $index"),
          ),
        );
      }),
    );
  }
}

class ListData extends StatelessWidget {
  const ListData({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, id) {
        return ListTile(
          leading: const Icon(Icons.add_box),
          title: Text("Item $id"),
        );
      },
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
        actions: const [
          Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.info)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Item 1"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.train),
              title: const Text("Item 2"),
              onTap: () {},
            ),
          ],
        ),
      ),
      endDrawer: Drawer(),
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
            // const MyListBuilder(),
            // const ListNumberBuilder()
            // const Test2(),
            const Test3(),
            const Test4(name: "Jessica"),
            const Counter(),
            const YesNo(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

enum Department { treasury, state }

class YesNo extends StatelessWidget {
  const YesNo({super.key});
  Future<Department?> _userChoice(BuildContext context) async {
    return showDialog<Department>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select assignment'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Department.treasury);
              },
              child: const Text('Treasury department'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Department.state);
              },
              child: const Text('State department'),
            ),
          ],
        );
      },
    );
  }

  // add SimpleDialog
  Future<void> _askedToLead(BuildContext context) async {
    switch (await _userChoice(context)) {
      case Department.treasury:
        debugPrint("treasury is selected");
        break;
      case Department.state:
        debugPrint("state is selected");
        break;
      case null:
        // dialog dismissed
        debugPrint("No value");
        break;
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Like the event ?'),
          content: const Text('Do you like this event'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                if (kDebugMode) {
                  debugPrint("Enable btn is pressed");
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Test showBottomSheet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showBottomSheetBuilder(BuildContext context) {
    // Added 'return' and proper generic type (showBottomSheet returns a PersistentBottomSheetController)
    return showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.blueAccent,
          height: 60, // Increased height slightly to fit the button
          child: Center(
            child: TextButton(
              // Corrected: TextButton needs a 'child' widget
              child: const Text(
                "Close BottomSheet",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    ).closed; // Use .closed to return a Future<void>
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      children: [
        TextButton(
          onPressed: () => _askedToLead(context),
          child: const Text("Help"),
        ),
        ElevatedButton(
          onPressed: () => _dialogBuilder(context),
          child: const Text("See more"),
        ),
        TextButton(
          onPressed: () => _showBottomSheetBuilder(context),
          child: const Text("Let's see"),
        ),
      ],
    );
  }
}

class Test4 extends StatelessWidget {
  final String name;
  const Test4({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(Icons.person), Text(name)],
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;
  void decrement() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        IconButton(
          onPressed: () => {
            setState(() {
              counter++;
            }),
          },
          icon: Icon(Icons.add),
        ),
        Text("${counter} in widigiet ${widget.key}"),
        IconButton(onPressed: decrement, icon: Icon(Icons.remove)),
      ],
    );
  }
}

class Test3 extends StatelessWidget {
  const Test3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: 40, height: 40, color: Colors.red),

        Positioned(child: const Text("Hello Flutter")),
      ],
    );
  }
}

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 260,
      // color: Colors.blueGrey,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [BoxShadow(color: Colors.grey)],
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      // transform: Matrix4.rotationZ(-0.25),
      child: const Text(
        "Get my dream!",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}

class MyListBuilder extends StatelessWidget {
  const MyListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> myList = List<int>.generate(100, (i) => i);
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
    return Column(
      children: const [Text("Hello"), Text("This is another custom widget")],
    );
  }
}

class ListNumber extends StatelessWidget {
  final int number;

  const ListNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Text('Number: $number');
  }
}

class ListNumberBuilder extends StatelessWidget {
  const ListNumberBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    final List<int> myList = List<int>.generate(10, (i) => i);
    return Column(
      children: [
        ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return ListNumber(number: myList[index]);
          },
        ),
      ],
    );
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
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1514377006585-6e7975371bd6?w=400&h=400&fit=crop',
          ),
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
