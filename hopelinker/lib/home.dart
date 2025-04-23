<<<<<<< HEAD

=======
import 'package:flutter/material.dart';
import 'map_page.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: MapPage(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(controller: _tabController,
                  tabs: [
                    Tab(text: 'Services'),
                    Tab(text: 'Events'),
                  ],
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.blue,
                  ),
                  Container(
                    height: 200,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(child: Text('Services List')),
                        Center(child: Text('Events List')),
                      ],
                    ),
                  )
                ],
              )
            )),
          )
        ],
      )
    );
  }
}
>>>>>>> b53d785a2ab84c06c8ff548979fd4d43572045cd
