# flutter_widgets

Widgets are the fundamental building blocks of user interfaces. Widgets can be thought of as UI components or elements, and you can use them to construct your app's user interface.

## Scaffold appBar and body
```dart
home: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: const Text("Hello world"),
          centerTitle: true,
          backgroundColor: Colors.purple,
          elevation: 5,
          leading: const Icon(Icons.menu),
          actions: [
            IconButton(
                onPressed: () {
                  debugPrint('clicked');
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
            child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.green[200],
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(20),
          child: const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 60,
          ),
        )),
      ),
```

## Row, column and expanded widget

### Column
flex option effects row height

```dart
home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 200,
                color: Colors.deepOrange,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: 200,
                color: Colors.pink,
              ),
            ),
            Expanded(
              child: Container(
                width: 200,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
```

### Row
flex option effects column width

```dart
home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.deepOrange,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.pink,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
```


## ListView
If the elements are larger than the screen size the widgets will overflow which will cause render overflow. In such cases *ListView* can be used to make the screen scrollable hence all widgets will fit and scroll

```dart
home: Scaffold(
        body: ListView(
          children: [
            Container(
              height: 350,
              color: Colors.deepOrange,
            ),
            Container(
              height: 350,
              color: Colors.pink,
            ),
            Container(
              height: 350,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
```

### ListView builder
List view builder, as the name suggests, helps in building a ListView from a list

```dart
List<String> names = ["Tom", "jerry", "pluto"];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(names[index]),
          ),
        ),
      ),
    );
```

## GridView
As the name suggest it helps create grid
```dart
  home: Scaffold(
        body: GridView.builder(
          itemCount: 64,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemBuilder: (context, index) => Container(
            color: Colors.indigo,
            margin: const EdgeInsets.all(2),
          ),
        ),
      )
```

## Stack
Stack works similar to column or row widget but instead it stacks all the children one on top of another. The last child is drawn on top.
```dart
body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.pink,
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.blueAccent,
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.orange,
            ),
          ],
        ),
``` 

## GestureDetector
Fire a function on tap on double tap etc

```dart
home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () => debugPrint("Hello world"),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Hello, world",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                ),
              ),
            ),
          ),
        ),
      ),
```


## navigation
There are few different ways to do this. 1st ways is the preferred method
> Using bottom navigation method

// main.dart
```dart
return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
      routes: {
        'firstpage': (context) => const FirstPage(),
        'homepage': (context) => const HomePage(),
        'settingspage': (context) => const Settingspage(),
        'profilepage': (context) => const ProfilePage(),
      },
    );
```

// first_page.dart
```dart
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List _pages = const [HomePage(), Settingspage(), ProfilePage()];
  int _selectedindex = 0;

  void _navigatorBottonpage(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("First page"),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedindex,
          onTap: _navigatorBottonpage,
          items: const [
            // home
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            // settings
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
            // profile
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: _pages[_selectedindex]);
  }
}
```

> Using drawer
// main.dart
```dart
return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
      routes: {
        'firstpage': (context) => const FirstPage(),
        'homepage': (context) => const HomePage(),
        'settingspage': (context) => const Settingspage(),
      },
    );
```

// first_page.dart
```dart
      appBar: AppBar(
        title: const Text("First page"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.favorite,
                size: 48,
              ),
            ),
            //home page list tite
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                // pop drawer first
                Navigator.pop(context);
                Navigator.pushNamed(context, 'homepage');
              },
            ),
            //settings page list tite
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("S E T T I N G S"),
              onTap: () {
                // pop drawer first
                Navigator.pop(context);
                Navigator.pushNamed(context, 'settingspage');
              },
            )
          ],
        ),
      ),
```

> Using routes

// main.dart
```dart
return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
      routes: {
        'firstpage': (context) => const FirstPage(),
        'secondpage': (context) => const SecondPage(),
      },
    );
```

// first_page.dart
```dart
return Scaffold(
      appBar: AppBar(
        title: const Text("First page"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'secondpage');
          },
          child: const Text("Page two"),
        ),
      ),
    );
```

> Using material page route
// First_page.dart
```dart
return Scaffold(
      appBar: AppBar(
        title: const Text("First page"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondPage(),
              ),
            );
          },
          child: const Text("Page two"),
        ),
      ),
    );
```

## Integrate Hive

### Install
add hive, hive_flutter, hive_generator and build_runner to pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  flutter_slidable: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  hive_generator: ^1.1.3
  build_runner: ^2.1.11
```

### Config
main.dart
```dart
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todoDB');

  runApp(const MyApp());
}
```

database file
lib/data/database.dart
```dart
import 'package:hive_flutter/adapters.dart';

class TodoDatabase {
  List todos = [];
  final _todoDB = Hive.box("todoDB");

  void _createDummyData() {
    todos = [
      [
        "Go to the Gym",
        "Cheat day today",
        false,
      ],
      [
        "Doctor's visit",
        "take health book",
        false,
      ]
    ];
  }

  void loadData() {
    var res = _todoDB.get("todos");
    if (res == null) {
      _createDummyData();
    } else {
      todos = res;
    }
  }

  void updateData() {
    _todoDB.put("todos", todos);
  }
}
```

get ans set data
```dart
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoDatabase db = TodoDatabase(); // <-- instance of database class

  @override
  void initState() {
    db.loadData(); // <-- load data
    super.initState();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  void toggleTodoTask(int index) {
    setState(() {
      db.todos[index][2] = !db.todos[index][2];
    });
    db.updateData(); // <-- update data
  }

  void addTodo({required String title, required String body}) {
    if (title.isEmpty || body.isEmpty) {
      return;
    }
    setState(() {
      db.todos = [
        [title, body, false],
        ...db.todos
      ];
      titleController.clear();
      bodyController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void deleteTodo(int index) {
    setState(() {
      db.todos.removeAt(index);
    });
    db.updateData();
  }
```
## Badges

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/) 
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)


## Author
- [@sonukuldeep](https://www.github.com/sonukuldeep)


## 🛠 Skills

[![My Skills](https://skillicons.dev/icons?i=js,ts,html,css,tailwind,sass,nodejs,react,nextjs,svelte,vue,flask,rust,python,php,solidity,mongodb,mysql,prisma,figma,threejs,unity,godot,dart,flutter)](https://github.com/sonukuldeep)