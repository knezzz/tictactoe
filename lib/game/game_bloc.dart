import 'package:rxdart/rxdart.dart';

enum SquareState { empty, cross, circle }

class GameBloc {
  GameBloc._(this.gameBoard) {
    _boardController.add(_getBoard);
  }

  factory GameBloc.newGame() {
    return GameBloc._(_makeEmptyState());
  }

  static List<List<SquareModel>> _makeEmptyState() {
    return List<List<SquareModel>>.generate(3, (int i) {
      return List<SquareModel>.generate(3, (int j) => SquareModel(SquareState.empty, i, j));
    });
  }

  /// UI Update
  final BehaviorSubject<List<SquareModel>> _boardController = BehaviorSubject<List<SquareModel>>();
  final BehaviorSubject<bool> _playerController = BehaviorSubject<bool>.seeded(true);

  /// Game stuff
  final List<List<SquareModel>> gameBoard;
  bool player = true;

  /// Helpers
  List<SquareModel> get _getBoard =>
      gameBoard.fold(<SquareModel>[], (List<SquareModel> list, List<SquareModel> row) => list..addAll(row));

  Stream<List<SquareModel>> get getBoardUpdates => _boardController.stream;
  Stream<bool> get getPlayer => _playerController.stream;

  /// On pressed
  void onPressed(SquareModel model) {
    print('${model.i} - ${model.j}');

    if (player) {
      gameBoard[model.i][model.j].state = SquareState.cross;
    } else {
      gameBoard[model.i][model.j].state = SquareState.circle;
    }

    player = !player;

    if (checkWinner(SquareState.circle) || checkWinner(SquareState.cross)) {
      /// Send game over/won here
      print('Someone won!');
    }

    _playerController.add(player);
    _boardController.add(_getBoard);
  }

  bool checkWinner(SquareState player) {
    bool flag = false;

    gameBoard.forEach((List<SquareModel> element) {
      flag = flag || element.fold(true, (bool value, SquareModel sm) => value && sm.state == player);
    });

    for (int i = 0; i < 3; i++) {
      bool _rowFlag = true;

      for (int j = 0; j < 3; j++) {
        _rowFlag = _rowFlag && gameBoard[j][i].state == player;
      }

      flag = flag || _rowFlag;
    }

    return flag;
  }

  void reset() {
    player = true;

    gameBoard.replaceRange(0, gameBoard.length, _makeEmptyState());

    _playerController.add(player);
    _boardController.add(_getBoard);
  }
}

class SquareModel {
  SquareModel(this.state, this.i, this.j);

  SquareState state;
  int i;
  int j;
}
