import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isOpen = false;
  List<bool> v = [false, false, false];
  String decisionDate = '';
  DateTime _selectedDate;
  String condition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                isOpen = !isOpen;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          'Filter',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50.0),
                        Text(
                          'select filters',
                        )
                      ],
                    ),
                  );
                },
                body: Container(
                  padding: EdgeInsets.only(left: 70.0),
                  child: Column(
                    children: [
                      buildCheckBox('No Kids Zone', v[0], 0),
                      buildCheckBox('Pet-Friendly', v[1], 1),
                      buildCheckBox('Free breakfast', v[2], 2),
                    ],
                  ),
                ),
                isExpanded: isOpen,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(17.0, 50.0, 0.0, 0.0),
            child: Text('Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        Text(
                          'check-in',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      decisionDate,
                      maxLines: 2,
                    ),
                  ],
                ),
                SizedBox(width: 70.0),
                SizedBox(
                  width: 200.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.lightBlue.shade100),
                    ),
                    child: Text('select date',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Future<DateTime> selectedDate = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2300),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light(),
                            child: child,
                          );
                        },
                      );
                      selectedDate.then((dateTime) {
                        setState(() {
                          _selectedDate = dateTime;
                          decisionDate =
                              DateFormat('yyyy-MM-dd').format(_selectedDate);
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            margin: EdgeInsets.only(top: 300.0),
            child: SizedBox(
              width: 150.0,
              height: 50.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlue),
                ),
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  _showDialog();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckBox(String name, bool value, int index) {
    return ListTile(
      leading: Checkbox(
        value: value,
        onChanged: (value) {
          setState(() {
            v[index] = value;
          });
        },
      ),
      title: Text(
        name,
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Text('Please check\nyour choice:)'),
          ),
          content: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(height: 1.0, color: Colors.lightBlue),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.wifi, color: Colors.lightBlue.shade200),
                    SizedBox(width: 5.0),
                    Text(
                      checkCondition(),
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.date_range, color: Colors.lightBlue.shade200),
                    Text(
                      'IN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      decisionDate,
                    )
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlue),
              ),
              child: Text('Search'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  String checkCondition() {
    String str = '';
    if (v[0]) {
      str += 'No Kids Zone/';
    }
    if (v[1]) {
      str += 'Pet-Friendly/';
    }
    if (v[2]) {
      str += 'Free breakfast/';
    }

    return str;
  }
}
