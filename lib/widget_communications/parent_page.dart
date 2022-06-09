import 'package:flutter/material.dart';
import 'child1_page.dart';
import 'child2_page.dart';

class ParentPage extends StatefulWidget {
  @override
  ParentPageState createState() => ParentPageState();
}

class ParentProvider extends InheritedWidget {
  final TabController? tabController;
  final Widget child;
  final String? title;

  ParentProvider({
    this.tabController,
    required this.child,
    this.title,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ParentProvider oldWidget) {
    return true;
  }

  static ParentProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ParentProvider>();
}

class ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  String myTitle = "My Parent Title";
  String? updateChild2title;
  String? updateChild1title;

  @override
  void initState() {
    _controller = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  updateChild2(String text) {
    setState(() {
      updateChild2title = text;
    });
  }

  updateParent(String text) {
    setState(() {
      myTitle = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ParentProvider(
      tabController: _controller,
      title: updateChild2title,
      child: Column(
        children: [
          ListTile(
            title: Text(
              myTitle,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            child: Text("Action 1"),
            onPressed: () {
              setState(() {
                updateChild1title = "Update from parent";
              });
            },
          ),
          const TabBar(
            tabs: [
              Tab(
                text: "First",
                icon: Icon(Icons.check_circle),
              ),
              Tab(
                text: "Second",
                icon: Icon(Icons.crop_square),
              )
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: _controller,
            children: [
              Child1Page(
                title: updateChild1title,
                child2Action2: updateParent,
                child2Action3: updateChild2,
              ),
              Child2Page(),
            ],
          ))
        ],
      ),
    );
  }
}
