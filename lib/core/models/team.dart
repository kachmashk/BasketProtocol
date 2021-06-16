import 'package:basketprotocol/core/models/player.dart';

class Team {
  final String name;
  final List<Player> players;

  int get points {
    var pts = 0;

    players.forEach((player) {
      pts += player.points;
    });

    return pts;
  }

  Team({required this.name, required this.players});
}
