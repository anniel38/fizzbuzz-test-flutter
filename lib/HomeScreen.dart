import 'package:fizzbuzz_test/fizzbuzz.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RangeValues _currentRangeValues = RangeValues(1, 100);
  int min;
  int max;


  @override
  void initState() {
    super.initState();
    min = _currentRangeValues.start.round();
    max = _currentRangeValues.end.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Fizz-Buzz Test'),
            actions: <Widget>[
              Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    _showHelpDialog();
                  },
                  child: Icon(
                    Icons.help,
                  )
              )
          )
        ],
      ),
      body: Column(
          children: [
            Spacer(),
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column (
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Range', style: TextStyle(fontWeight: FontWeight.bold)),
                      RangeSlider(
                        values: _currentRangeValues,
                        min: 1,
                        max: 100,
                        divisions: 100,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                            min = _currentRangeValues.start.round();
                            max = _currentRangeValues.end.round();
                          });
                        },
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text('${min.toString()}'),
                          Spacer(flex: 5),
                          Text('${max.toString()}'),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.format_list_numbered),
                            Text(' List', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        onPressed: () {
                          _showResult(min, max);
                        },
                      ),
                    ],
                  ),
                )
            ),
            Spacer(flex: 3),
          ],
        ),
    );
  }


  void _showResult(int _min, int _max) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          title: Text('Fizz-Buzz'),
          content: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    TextSpan(
                      text: _min==max? 'Number: ${_min}\n\n':'Range: ${_min.toString()} - ${_max.toString()}\n\n',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    TextSpan(
                      text: 'Result: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${fizzbuzz(_min, _max)}',
                    )
                  ]
              )
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }


  _showHelpDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About Fizz-Buzz'),
          content: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    TextSpan(
                        text:'FizzBuzz has been used as an interview screening device for computer programmers. '
                            ' Writing a program that prints the numbers from 1 to 100 and for multiples of ‘3’ print “Fizz”'
                            ' instead of the number and for the multiples of ‘5’ print “Buzz” is a relatively trivial '
                            'problem requiring little more than a loop and conditional statements. '
                            'However, its value in coding interviews is to analyze fundamental '
                            'coding habits that may be indicative of overall coding ingenuity.'),
                  ]
              )
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}