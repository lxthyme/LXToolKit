import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
// import 'package:flutter_un';

class FlutterUnitPage extends StatefulWidget {
  final String title;
  const FlutterUnitPage({super.key, this.title = ""});

  @override
  State<StatefulWidget> createState() => _FlutterUnitPageState();
}

class _FlutterUnitPageState extends State<FlutterUnitPage> with SingleTickerProviderStateMixin {
  List<String> get _tabs => [
        '无态',
        '有态',
        '单渲',
        '多渲',
        '滑片',
        '代理',
        '其它',
      ];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _switchTab(int idx) {
    // WidgetFamily
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: _buildHeader,
              body: const Center(
                child: Text('Hello World2!'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    Color themeColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return [
      SliverPersistentHeader(
        pinned: true,
        delegate: _FlutterUnitPageDelegate(
          color: isDark ? Colors.black : Colors.white,
          child: TabBar(
            tabs: _tabs.map((e) => Tab(text: e)).toList(),
            onTap: _switchTab,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            // indicator: Round,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            controller: tabController,
            labelColor: themeColor,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.grey,
            indicatorColor: themeColor,
          ),
        ),
      ),
    ];
  }
}

class _FlutterUnitPageDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color color;
  _FlutterUnitPageDelegate({required this.child, required this.color});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: color,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _FlutterUnitPageDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.color != color;
  }
}
