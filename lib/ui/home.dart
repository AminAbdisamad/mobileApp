import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './tracks.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Touch Me',
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[50]
              : null),
      home: new Home("Touch Me!!"),
      // Routing Pages
      // routes: <String, WidgetBuilder>{
      //   "/tracks": (BuildContext context) => new Tracks("Tracks"),
      // },
    );
  }
}

class Home extends StatefulWidget {
  final String title;
  Home(this.title);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  void _counterIncrement() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        // leading: new IconButton(
        //   icon: Icon(Icons.menu, color: Colors.white),
        //   onPressed: null,
        // ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchData());
              })
        ],
      ),
// Drawer Menu
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountEmail: new Text("amiin@asalsolutions.com"),
            accountName: new Text("Amin Abdisamad"),
            currentAccountPicture: new CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.deepOrange
                        : null,
                child: new Text("A")),

            // Create Other Cirle pictures
            otherAccountsPictures: <Widget>[
              new CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.deepOrange
                          : null,
                  child: Text("B")),
            ],
          ),
          new ListTile(
            title: new Text('Workshop Tracks',
                style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
          ),
          new ListTile(
            title: new Text('Network Architecture'),
            trailing: new Icon(
              Icons.event,
            ),

            // Route to Another Page
            onTap: () {
              // Closing Navigation Menu
              Navigator.of(context).pop();
              //  Routing Pages
              // Navigator.of(context).pushNamed('/tracks');

              // Another Way to implement
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new Tracks("Network Infrastructure")));
            },
          ),
          new ListTile(
            title: new Text('Systems and Services'),
            trailing: new Icon(
              Icons.event,
            ),
            onTap: () {
              // Closing Navigation Menu
              Navigator.of(context).pop();

              // Another Way to implement
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new Tracks("Systems and Services")));
            },
          ),
          new ListTile(
            title: new Text('Advanced Routing'),
            trailing: new Icon(
              Icons.event,
            ),
            onTap: () {
              // Closing Navigation Menu
              Navigator.of(context).pop();

              // Another Way to implement
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new Tracks("Advanced Routing")));
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text('Close'),
            trailing: new Icon(
              Icons.close,
            ),
            // Closing the Menu
            onTap: () => Navigator.of(context).pop(),
          )
        ],
      )),
      body: new Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // RaisedButton(
              //   color: Colors.green,
              //   onPressed: null,
              //   child: Text("Click Me", style: TextStyle(color: Colors.white)),
              // ),
              new Text("You touched me $_counter Times",
                  style: TextStyle(fontSize: 20.5, color: Colors.blue))
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: new Icon(
          Icons.event,
          color: Colors.blue,
        ),
        onPressed: _counterIncrement,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Add Bottom Navigation With Color
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.blue,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.white,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white)),
        ), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.info),
              title: new Text("Info"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.add_location),
              title: new Text("Map"),
            )
          ],
        ),
      ),
    );
  }
}

// Search Data

class SearchData extends SearchDelegate<String> {
// Create list variable
  final cities = [
    'Mogadishu',
    'Hargeisa',
    'Kismayo',
    'Bosaaso',
    'Baydhabo',
    'Baladweyne',
    'Boorame',
    'Jigjiga',
    'Laasanod',
    'Xudur',
    'Marka',
    'Garoowe',
    'Burco'
  ];
  final recentCities = [
    'Mogadishuss',
    'Hargeisa',
    'Kismayo',
    'Bosaaso',
    'Baydhabo'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Define sugestion list variable
// TODO : Upercase Automatically
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            onTap: () {
              showResults(context);
            },
            leading: Icon(Icons.location_city),
            // title: Text(suggestionList[index]),
            // Bold searched Text
            title: RichText(
              text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(
                        color: Colors.grey,
                      ))
                ],
              ),
            ),
          ),
      itemCount: suggestionList.length,
    );
  }
}
