/**
 * Preferences model stores a map in the user document of the database
 *
 */

class Preferences_Model {
  // each setting will have a variable in the preference model
  int? graphModel;
  int? numDaystoDisplay;
  Map<String, dynamic> preferences;

  Preferences_Model({this.graphModel, this.numDaystoDisplay, this.preferences});
}

int getGraphModel() {
  return graphModel;
}

void setGraphModel(int graphModel) {
  this.graphModel = graphModel;
}

int getNumDays() {
  return numDaystoDisplay;
}

void setNumDays(int numDaystoDisplay) {
  this.numDaystoDisplay = numDaystoDisplay;
}
