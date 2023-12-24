import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainList extends StatelessWidget {
  const MainList({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tutorial List'),
        ),
        body: const List(),
      ),
    );
  }
}

class List extends StatelessWidget {
  const List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ListTile(
            title: const Text('/daily/widgets-intro/hw2', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Subtitle'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
            onTap: () => {
              context.push('/daily/widgets-intro/hw2')
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('/daily/widgets-intro/hw3', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Subtitle'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
            onTap: () => {
              context.push('/daily/widgets-intro/hw3')
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('/daily/widgets-intro/mybutton', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Subtitle'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
            onTap: () => {
              context.push('/daily/widgets-intro/mybutton')
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('/daily/widgets-intro/counter', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Subtitle'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
            onTap: () => {
              context.push('/daily/widgets-intro/counter')
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('/gallery/cupertino/list/cupertino_activity_indicator_demo', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('Subtitle'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
            onTap: () => {
              context.push('/gallery/cupertino/list/cupertino_activity_indicator_demo')
            },
          ),
        ],
      ),
    );
  }
}
