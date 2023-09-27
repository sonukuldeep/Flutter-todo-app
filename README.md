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





## Badges

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/) 
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)


## Author
- [@sonukuldeep](https://www.github.com/sonukuldeep)


## 🛠 Skills

[![My Skills](https://skillicons.dev/icons?i=js,ts,html,css,tailwind,sass,nodejs,react,nextjs,svelte,vue,flask,rust,python,php,solidity,mongodb,mysql,prisma,figma,threejs,unity,godot,dart,flutter)](https://github.com/sonukuldeep)