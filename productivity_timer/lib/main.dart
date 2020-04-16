import 'package:flutter/material.dart';

import 'timer.dart';
import 'timermodel.dart';
import 'timermodel.dart';
import 'widgets.dart';

import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'My Work Timer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff009688),
                        text: 'Work',
                        onPressed: emptyMethod,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff607D88),
                        text: 'Short Break',
                        onPressed: emptyMethod,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff455A64),
                        text: 'Long Break',
                        onPressed: emptyMethod,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: timer.stream(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        TimerModel timer = (snapshot.data == '00:00')
                            ? TimerModel('00:00', 1)
                            : snapshot.data;
                        return CircularPercentIndicator(
                          radius: availableWidth / 2,
                          lineWidth: 10.0,
                          percent: timer.percent,
                          center: Text(
                            timer.time,
                            style: Theme.of(context).textTheme.display1,
                          ),
                          progressColor: Color(0xff009688),
                        );
                      }),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                          color: Color(0xff212121),
                          text: 'Stop',
                          onPressed: timer.stopTimer),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: 'Restart',
                          onPressed: timer.startTimer),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                )
              ],
            );
          },
        ));
  }

  void emptyMethod() {}
}
