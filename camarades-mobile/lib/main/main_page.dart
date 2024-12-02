import 'package:camarades/home/pages.dart';
import 'package:camarades/profile/pages.dart';
import 'package:camarades/school_career/pages.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;
  final _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      _selectedPageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (pageIndex) => _onPageChanged(pageIndex),
        children: <Widget>[
          ProfilePage(),
          HomePage(),
          SchoolCareerPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.lightBlue),
        iconSize: 33,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profil'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Accueil'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Parcours scolaire'),
          ),
        ],
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
