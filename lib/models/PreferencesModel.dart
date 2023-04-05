/// Preferences model stores a map in the user document of the database
/// Each variable will have a value assigned to it, this value will be used
/// to present the user with the desirable information

// ignore: camel_case_types
class Preferences_Model {
  // each setting will have a variable in the preference model
  int? graphModel;
  int? numDaysToDisplay;
  late Map<String, dynamic> preferences = {
  'Graph Model' : graphModel,
  'Number of Days to Display' : numDaysToDisplay,
};

  Preferences_Model({
    required this.graphModel,
    required this.numDaysToDisplay,
  });

  int? getGraphModel() {
    return graphModel;
  }

  void setGraphModel(int graphModel) {
    this.graphModel = graphModel;
    preferences['Graph Model'] = graphModel;
  }

  int? getNumDays() {
    return numDaysToDisplay;
  }

  void setNumDays(int numDaysToDisplay) {
    this.numDaysToDisplay = numDaysToDisplay;
    preferences['Number of Days to Display'] = numDaysToDisplay;
  }
}
