import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      theme: ThemeData(primaryColor: Colors.indigoAccent[700]),
    );
  }
}

class ListMonth {
  int monthvalue;
  String monthname;
  ListMonth(this.monthvalue, this.monthname);
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

int _monthvalue;
int _dayvalue;
String datas = 'Please Select Month & Date of your Date of Berth';
TextStyle style = TextStyle(fontSize: 17, color: Colors.black);
List<ListMonth> listofmonth = [
  ListMonth(1, "January"),
  ListMonth(2, "Fabruary"),
  ListMonth(3, "March"),
  ListMonth(4, "April"),
  ListMonth(5, "May"),
  ListMonth(6, "June"),
  ListMonth(7, "July"),
  ListMonth(8, "August"),
  ListMonth(9, "September"),
  ListMonth(10, "October"),
  ListMonth(11, "November"),
  ListMonth(12, "December"),
];

List<int> days29 = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29
];
List<int> days30 = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30
];
List<int> days31 = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31
];

List<int> days = days31;
bool isSuccess = false;
bool isCirculer = false;
BoxDecoration boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
);

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[700],
      appBar: AppBar(
        elevation: 0,
        title: Center(
            child: Text(
          'Welcome To The Past',
        )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Text(
                    datas,
                    style: style,
                    textAlign: TextAlign.center,
                  ),
                ),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: boxDecoration,
              ),
              SizedBox(
                height: 20,
              ),
              monthfeild(),
              SizedBox(
                height: 20,
              ),
              daysfeild(),
              SizedBox(
                height: 20,
              ),
              isCirculer
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.amber,
                        onPressed: () async {
                          if (_dayvalue != null && _monthvalue != null) {
                            setState(() {
                              isCirculer = true;
                              datas = 'Please wait.....';
                              style =
                                  TextStyle(fontSize: 17, color: Colors.blue);
                            });
                            await get(
                                _dayvalue.toString(), _monthvalue.toString());
                          } else {
                            setState(() {
                              datas = 'Please Select Both month and date';
                              style = TextStyle(
                                  fontSize: 17, color: Colors.red[400]);
                            });
                          }
                        },
                        child: Text(
                          'Check',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: Colors.indigoAccent,
                  onPressed: () async {
                    setState(() {
                      isSuccess = false;
                      _dayvalue = null;
                      datas =
                          'Please Select Month & Date of your Date of Berth';
                      style = TextStyle(fontSize: 17, color: Colors.black);
                      _monthvalue = null;
                      isCirculer = false;
                    });
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Make sure your internet  ',
                      style: TextStyle(color: Colors.white30, fontSize: 17)),
                  Icon(
                    Icons.wifi,
                    color: Colors.white,
                  ),
                  Text(
                    ' OK',
                    style: TextStyle(fontSize: 17, color: Colors.white30),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  monthfeild() {
    return Container(
        decoration: boxDecoration,
        padding: EdgeInsets.only(left: 20, top: 10, right: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: DropdownButton(
          elevation: 10,
          isDense: true,
          isExpanded: true,
          iconEnabledColor: Colors.blue,
          icon: Icon(Icons.arrow_downward),
          // elevation: 10,
          value: _monthvalue,
          items: listofmonth.map((ListMonth lm) {
            return DropdownMenuItem<int>(
              child: Center(child: Text(lm.monthname)),
              value: lm.monthvalue,
            );
          }).toList(),
          hint: Text("Select Month"),
          disabledHint: Text('Disabled'),
          onChanged: (value) {
            setState(() {
              _monthvalue = value;
              if (value == 2) {
                days = days29;
              } else if (value == 1 ||
                  value == 3 ||
                  value == 5 ||
                  value == 7 ||
                  value == 8 ||
                  value == 10 ||
                  value == 12) {
                days = days31;
              } else {
                days = days30;
              }
            });
          },
        ));
  }

  daysfeild() {
    return Container(
        decoration: boxDecoration,
        padding: EdgeInsets.only(left: 20, top: 10, right: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: DropdownButton(
          hint: Text('Select Date'),
          icon: Icon(Icons.arrow_downward),
          iconEnabledColor: Colors.blue,
          isExpanded: true,
          isDense: true,
          value: _dayvalue,
          items: days.map((d) {
            return DropdownMenuItem<int>(
              child: Center(child: Text('$d')),
              value: d,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _dayvalue = value;
            });
          },
        ));
  }

  Future<Map> get(String dat, String mnt) async {
    try {
      await http.get(
          Uri.parse("https://numbersapi.p.rapidapi.com/" +
              mnt +
              "/" +
              dat +
              "/date?fragment=true&json=true"),
          headers: {
            "x-rapidapi-key":
                "8b6b646719msh3ef91bb12a9bb30p10e84fjsn126c38b8e506",
            "x-rapidapi-host": "numbersapi.p.rapidapi.com"
          }).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          Map data = json.decode(response.body.toString());
          setState(() {
            datas = data['text'].toString() +
                '\n in year ' +
                data['year'].toString();
            style = TextStyle(
                fontSize: 15,
                color: Colors.indigoAccent[700],
                fontWeight: FontWeight.bold);
            isSuccess = true;
            isCirculer = false;
          });
          print(data['text'].toString());
        } else {
          setState(() {
            datas = 'Something Went Wrong\nTry Again';
            style = TextStyle(fontSize: 17, color: Colors.red[400]);
            isSuccess = true;
            isCirculer = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        datas = 'Something Went Wrong\nTry Again';
        style = TextStyle(fontSize: 17, color: Colors.red[400]);
        isSuccess = true;
        isCirculer = false;
      });
      print(e.toString());
    }
  }
}
