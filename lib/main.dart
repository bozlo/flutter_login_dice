import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice game',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){}
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // TextField의 키보드가 나온 경우, 다른 곳으로 focus를 옮기면(focus를 잃어버리면)
          // 키보드가 내려가게 된다.
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.0,),
              Center(
                child: Image(
                  image: AssetImage('image/chef.gif'),
                  width: 190.0,
                  height: 210.0,
                ),
              ),
              Form(child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.teal,
                  inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          labelText: "Enter dice"
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                            labelText: "Enter password"
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 40.0,),
                      ButtonTheme(
                        minWidth: 100.0,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controllerEmail.text == 'dice' &&
                                 controllerPassword.text == '1234') {
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>Dice()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('invalid credential',
                                      textAlign: TextAlign.center,
                                      ),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.blue),
                              );
                            }
                          },
                          child: Icon(Icons.arrow_forward,
                            color: Colors.white,
                            size: 35.0,),
                        ),)
                    ],
                  ),
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int leftDice = 1;
  int rightDice = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text("Dice"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Image.asset('image/dice$leftDice.png')),
                  SizedBox(width: 20.0),
                  Expanded(child: Image.asset('image/dice$rightDice.png')),
                ],
              ),
            ),
            SizedBox(height: 60.0,),
            ButtonTheme(
              minWidth: 100.0,
                height: 60.0,
                child: ElevatedButton(child: Icon(Icons.play_arrow,
                  color: Colors.white,
                  size: 50,),
                  onPressed: () {
                    setState(() {
                      leftDice = Random().nextInt(6) + 1;
                      rightDice = Random().nextInt(6) + 1;
                    });

                    showToast("Left Dice = {$leftDice}, Right dice={$rightDice}");
                  },)),
          ],
        ),
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(msg: message,
  backgroundColor: Colors.white,
  toastLength: Toast.LENGTH_SHORT,
  textColor: Colors.black,
  gravity: ToastGravity.BOTTOM);
}