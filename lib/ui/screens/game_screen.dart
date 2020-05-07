import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/game/game_bloc.dart';
import 'package:tictactoe/game/square_widget.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final GameBloc _gb = Provider.of<GameBloc>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: StreamBuilder<bool>(
              stream: _gb.getPlayer,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return Text((snapshot?.data ?? true) ? 'Player one playing' : 'Player two playing');
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder<List<SquareModel>>(
              stream: _gb.getBoardUpdates,
              builder: (BuildContext context, AsyncSnapshot<List<SquareModel>> snapshot) {
                return Container(
                  margin: const EdgeInsets.all(2.0),
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisSpacing: 2.0, crossAxisSpacing: 2.0),
                    children: snapshot.data
                        .map((SquareModel ss) => SquareWidget(
                              ss,
                              onPressed: () {
                                _gb.onPressed(ss);
                              },
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: RaisedButton(
              child: Text('Reset game'),
              onPressed: _gb.reset,
            ),
          ),
        ],
      ),
    );
  }
}
