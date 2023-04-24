class PreferencesModel {
  // each setting will have a variable in the preference model
  String sleepGraphType;
  int numDaysToDisplay;
  int wakeUpHour;

  PreferencesModel({
    this.sleepGraphType = "bar",
    this.numDaysToDisplay = 7,
    this.wakeUpHour = 7,
  });

  Map<String, dynamic> asMap() {
    return {
      "sleepGraphType": sleepGraphType,
      "numDaysToDisplay": numDaysToDisplay,
      "wakeUpHour": wakeUpHour
    };
  }
}
