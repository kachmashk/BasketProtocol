class Player {
  final String name;
  int get points {
    return (1 * onePointMade) + (2 * twoPointsMade) + (3 * threePointsMade);
  }

  int assists = 0;
  int turnovers = 0;
  int blocks = 0;
  int fouls = 0;

  int onePointMade = 0;
  int onePointAttempts = 0;

  int twoPointsMade = 0;
  int twoPointsAttempts = 0;

  int threePointsMade = 0;
  int threePointsAttempts = 0;

  int offensiveRebounds = 0;
  int defensiveRebounds = 0;

  int get rebounds {
    return offensiveRebounds + defensiveRebounds;
  }

  Player({required this.name});
}
