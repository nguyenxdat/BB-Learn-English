import 'package:bb_earn_english/api/network.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BB Learn English'),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchPhotos(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data[index].url),
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].url),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(snapshot.data[index])));
                      },
                    );
                  });
            } else if (snapshot.hasError) {
              return Container(
                child: Center(child: Text('Not Found Data')),
              );
            } else {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
