import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Stopwatch',
      home: Stopwatch(),
      debugShowCheckedModeBanner: false,
      ),);
class Stopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Timer _timer;
  final _formatter = DateFormat('HH:mm:ss.S');

  var StartTime = 0;
  var NowTime = 0;
  var RunState = 0; // 0:stop, 1:run

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(milliseconds: 123),
          (_t) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (RunState==1){
      NowTime = DateTime.now().millisecondsSinceEpoch.toInt();
    }

    void _startButton(){
      if (RunState == 0){
        StartTime = DateTime.now().millisecondsSinceEpoch.toInt();
        NowTime = DateTime.now().millisecondsSinceEpoch.toInt();
        RunState = 1;
      }
    }

    void _stopButton(){
      if (RunState == 1){
        RunState = 0;
      }
      else{
        StartTime = 0;
        NowTime = 0;
      }
    }

    var diffTime = DateTime.fromMillisecondsSinceEpoch(NowTime - StartTime).toUtc();

    return Center(
      child: Container(
        height: 330,
        width: 340,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text("Stopwatch",style: TextStyle(color: Colors.cyanAccent,fontSize: 50),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 22,bottom: 34),
              child: Text('${_formatter.format(diffTime)}',style: TextStyle(color: Colors.pinkAccent,fontSize: 50),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 65,
                  width: 65,
                  child:FloatingActionButton(
                  onPressed: _startButton,
                  child: Icon(Icons.play_arrow,size: 47,),
                  backgroundColor: Colors.green,
                ),
                ),
                SizedBox(
                  height: 65,
                  width: 65,
                  child:FloatingActionButton(
                  onPressed: _stopButton,
                  child: Icon(Icons.stop,size: 47,),
                    backgroundColor: Colors.red,
                ),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white12,
            width: 8,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white70,
              offset: Offset(2,2),
              blurRadius: 20,
            )
          ]
        ),
      ),
    );
  }
}