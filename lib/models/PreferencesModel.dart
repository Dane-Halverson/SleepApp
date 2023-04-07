class PreferencesModel {
  // each setting will have a variable in the preference model
  String sleepGraphType;
  int numDaysToDisplay;

  PreferencesModel({
    this.sleepGraphType = "bar",
    this.numDaysToDisplay = 7,
  });

  Map<String, dynamic> asMap() {
    return {
      "sleepGraphType": sleepGraphType,
      "numDaysToDisplay": numDaysToDisplay
    };
  }
}
