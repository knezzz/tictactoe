import 'package:flutter/material.dart';
import 'package:tictactoe/ui/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => GameScreen()));
                },
                child: Text('New game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
