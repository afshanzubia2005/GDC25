import 'package:flutter/material.dart';
import 'package:hopelinker/profile.dart';
import 'map_page.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade200, Colors.yellow.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logosidetitle.png',
              height: 40,
              fit: BoxFit.contain,
            ),
            Row(
              children: [
                Icon(Icons.search, color: Colors.black),
                SizedBox(width: 10),
                Icon(Icons.notifications, color: Colors.black),
                SizedBox(width: 10),
                Icon(Icons.bookmark, color: Colors.black),
                SizedBox(width: 10),
                Icon(Icons.filter, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Map layer at the bottom
          Positioned.fill(child: MapPage()),
          // Sliding panel for tabs
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [Tab(text: 'Services'), Tab(text: 'Events')],
                    labelColor: const Color(0xFF37A5FF),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFF37A5FF),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16),
                                leading: Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.black54,
                                  ),
                                ),
                                title: Text('Food Pantry'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('3/29/2025'),
                                    Text('Veteran O tags'),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.notifications),
                                    Icon(Icons.bookmark),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Center(child: Text('Events List')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80, // Height remains larger for better visibility
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mappage/homebackgroundCopy.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Theme(
          data: ThemeData(
            canvasColor: Colors.transparent, // Ensure full transparency
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent, // Fully transparent background
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/mappage/homeicon.png', height: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/mappage/forum.png', height: 30),
                label: 'Forum',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/mappage/chatbot.png', height: 30),
                label: 'Chatbot',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/mappage/profile.png', height: 30),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF37A5FF),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (index) {
              if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
