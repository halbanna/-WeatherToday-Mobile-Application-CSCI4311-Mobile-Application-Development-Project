import 'dart:convert';
import 'package:weathertoday/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants{
  static final BASE_URL='http://api.openweathermap.org/data/2.5/weather?q=';
}

class MyHomePage extends StatefulWidget {

   final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = '';
  String value2 = '';

  @override
  void initState() {
    super.initState();
    // _getData(context,);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new  TextEditingController();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.0,
                1.0,

              ],
              colors: [
                Colors.black12,
                Colors.blueGrey,
              ],
            )
        ),


      child: Scaffold(appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('WeatherToday',
          style: GoogleFonts.itim(color: Colors.white,),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(children:[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "What's the weather like?",
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 27),
              ),

            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter city name (i.e. Gombak)",
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    color: Colors.amber,
                    onPressed: () {
                      showLoaderDialog(context);
                      _getData(context,_controller.text);},
                    icon: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100,),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: GoogleFonts.robotoSlab(color: Colors.white, fontSize: 33),
                    ),

                  ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value2,
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 74, fontWeight: FontWeight.w900),
                ),
                ),


                  Text(
                    '',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ],),
        ),
      ]),


      ));
  }

  _getData(
      BuildContext context,String city,
      ) async {
    final uri = Constants.BASE_URL +city+
        '&APPID=5fcc1ed82149c74f4644a946551ded05';

    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response getResponse = await get(Uri.parse(uri), headers: headers);

    setState(() {
      Navigator.pop(context);
      int statusCode = getResponse.statusCode;
      String responseBody = getResponse.body;
      print('response----' + responseBody);
      var loginResponse = weatherResponeFromJson(responseBody);
      if (loginResponse.main != null) {
        print(" status 200");


        String city = loginResponse.name;
        int icon = loginResponse.weather[0].id;
        String description = loginResponse.weather[0].description;
        String iconIcon = getWeatherIcon(icon);
        double tempInCelcius = loginResponse.main.temp - 273.15;
        var temp= new Runes(tempInCelcius.toStringAsPrecision(3) +'\u00B0C\n');
        String temperature = new String.fromCharCodes(temp);
        value = city + '\n'  + description ;
        value2 =  temperature + iconIcon;
      } else {
        _showAlert(context, "Some error occured, Try again!!!");
      }
    });
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  void _showAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login"),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

String getWeatherIcon(int weather) {
  if (weather < 300) {
    return '🌩';
  } else if (weather < 400) {
    return '🌧';
  } else if (weather < 600) {
    return '☔';
  } else if (weather < 700) {
    return '☃';
  } else if (weather < 800) {
    return '🌫';
  } else if (weather == 800) {
    return '☀';
  } else if (weather <= 804) {
    return '☁';
  } else {
    return '🤷‍';
  }
}

