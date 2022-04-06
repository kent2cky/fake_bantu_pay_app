import 'package:fake_bantu_pay/ui/history.dart';
import 'package:fake_bantu_pay/ui/home.dart';
import 'package:flutter/material.dart';

import 'settings.dart';
import 'swap.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final _controller = PageController();

  static final List<Widget> _pages = [
    Home(),
    const Swap(),
    History(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages, //New
      ),
      bottomNavigationBar: Container(
        color: Colors.amber,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          elevation: 20,
          // backgroundColor: Colors.white,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: const IconThemeData(color: Colors.black, size: 30),
          selectedFontSize: 25,
          fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wifi_protected_setup),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update_sharp),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
