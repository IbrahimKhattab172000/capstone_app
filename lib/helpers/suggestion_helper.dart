class SuggestionHelper {
  static SuggestionData generateSuggestion({
    required int distance,
    // required int heartRate,
  }) {
    // Distance logic
    if (distance < 5) {
      return SuggestionData(
        text:
            'Flow meter RedZone from 60 to 150 l/min\nNeed to go to the doctor instantly. And take inhaler right away',
        // imagePath: AssetsManager.redZone,
      );
    } else if (distance >= 5 && distance < 9) {
      return SuggestionData(
        text:
            'Yellow zone from 150 to 350 l/min\nNeed to take the inhaler once per day and with every decrease by 100 take it twice more',
        // imagePath: AssetsManager.yellowZone,
      );
    } else {
      return SuggestionData(
        text:
            'Green zone from 350 to 700 l/min\nYou don\'t need to take any inhalers',
        // imagePath: AssetsManager.greenZone,
      );
    }
  }
}

class SuggestionData {
  final String text;
  // final String imagePath;

  SuggestionData({
    required this.text,
    // required this.imagePath,
  });
}


//TODO: check the else case and what if the distance is 6 also