/// Preferences model stores a map in the user document of the database
/// Each variable will have a value assigned to it, this value will be used
/// to present the user with the desirable information
import "charts.dart";

class PreferencesModel {
  // each setting will have a variable in the preference model
  String sleepGraphType;
  int numDaysToDisplay;

  PreferencesModel({
    this.sleepGraphType = "bar",
    this.numDaysToDisplay = 7,
  });

  int? getNumDays() {
    return numDaysToDisplay;
  }

  Map<String, dynamic> asMap() {
    return {
      "sleepGraphType": sleepGraphType,
      "numDaysToDisplay": numDaysToDisplay
    };
  }
}
