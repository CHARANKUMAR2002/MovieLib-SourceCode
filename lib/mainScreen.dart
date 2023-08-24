import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviestream/homepage.dart';
import 'search_series.dart';
import 'add_movies.dart';
import 'package:moviestream/search.dart';
import 'package:moviestream/series.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int page = 0;
  final Screens = [HomePage(), searchMovies(), tvSeries(), searchSeries()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > 640 ? 
      Row(
        children: [
          Container(
              padding: EdgeInsets.only(left: 10),
                child: 
            IntrinsicHeight(
              child: 
          NavigationRail(
            indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(8), topRight: Radius.circular(8))),
            indicatorColor: Color.fromARGB(150, 33, 149, 243),
            labelType: NavigationRailLabelType.all,
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            onDestinationSelected: (value) => setState(() {page = value;}),
          destinations: [
            NavigationRailDestination(icon: Icon(FontAwesomeIcons.film, color: Colors.white),label: Text("Movies")),
            NavigationRailDestination(icon: Icon(Icons.search_rounded, color: Colors.white), label: Text("Search Movies")),
            // NavigationRailDestination(icon: Icon(Icons.upload_file, color: Colors.white), label: Text("Add Movies")),
            NavigationRailDestination(icon: Icon(Icons.live_tv_rounded, color: Colors.white), label: Text("Series")),
            NavigationRailDestination(icon: Icon(Icons.screen_search_desktop_outlined, color: Colors.white), label: Text("Search Series")),
          ],
          selectedIndex: page,
          ),)),
          Expanded(child: Screens[page]),
        ],
      ) : Screens[page],
      bottomNavigationBar:  MediaQuery.of(context).size.width <=640 ? NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Color.fromARGB(150, 33, 149, 243)),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 65.0,
          indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(8), topRight: Radius.circular(8))),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          onDestinationSelected: (value) => setState(() {page = value;}),
          destinations: [
            NavigationDestination(icon: Icon(FontAwesomeIcons.film, color: Colors.white,),label: "Movies", ),
            NavigationDestination(icon: Icon(Icons.search_rounded,color: Colors.white),label: "Search Movies", ),
            // NavigationDestination(icon: Icon(Icons.upload_file, color: Colors.white), label: "Add Movies"),
            NavigationDestination(icon: Icon(Icons.live_tv_rounded, color: Colors.white), label: "Series"),
            NavigationDestination(icon: Icon(Icons.screen_search_desktop_outlined, color: Colors.white), label: "Search Series"),
          ],
          selectedIndex: page,
        ),
      ) : null
    );
  }
}