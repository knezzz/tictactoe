import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/game/game_bloc.dart';

class SquareWidget extends StatelessWidget {
  SquareWidget(this.model, {this.onPressed, Key key}) : super(key: key);

  final SquareModel model;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Widget child;

    bool player = Provider.of<GameBloc>(context).player;

    switch (model.state) {
      case SquareState.cross:
        child = Container(
          child: Center(
            child: Text(
              'X',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        );
        break;
      case SquareState.circle:
        child = Container(
          child: Center(
            child: Text(
              'O',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        );
        break;
      default:
        child = Container();
    }

    return Material(
      type: MaterialType.card,
      color: Theme.of(context).dividerColor,
      child: InkWell(
        splashColor: player ? Colors.red : Colors.blue,
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
