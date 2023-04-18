import 'package:flutter/material.dart';
//import 'package:book/Preferences_model.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key, required this.preferences}) : super(key: key);

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // create a Preferences_Model instance with initial values
  final _preferences = Preferences_Model(
    graphModel: widget.preferences.graphModel,
    numDaysToDisplay: widget.preferences.numDaysToDisplay,
  );

  // controllers for the text field and radio buttons
  final _numDaysController = TextEditingController();
  late int _graphModel;

  @override
  void initState() {
    super.initState();
    _numDaysController.text = _preferences.numDaysToDisplay.toString();
    _graphModel = _preferences.graphModel!;
  }

  @override
  void dispose() {
    _numDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Graph Model',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _graphModel,
                  onChanged: (value) {
                    setState(() {
                      _graphModel = value!;
                    });
                  },
                ),
                Text('Line'),
                Radio<int>(
                  value: 1,
                  groupValue: _graphModel,
                  onChanged: (value) {
                    setState(() {
                      _graphModel = value!;
                    });
                  },
                ),
                Text('Bar'),
                Radio<int>(
                  value: 2,
                  groupValue: _graphModel,
                  onChanged: (value) {
                    setState(() {
                      _graphModel = value!;
                    });
                  },
                ),
                Text('Pie'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Number of Days to Display',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _numDaysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a number',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // save preferences
                    _preferences.setGraphModel(_graphModel);
                    _preferences.setNumDays(int.parse(_numDaysController.text));
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // reset preferences to defaults
                    _graphModel = 0;
                    _numDaysController.text = _preferences.numDaysToDisplay.toString();
                    setState(() {});
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
