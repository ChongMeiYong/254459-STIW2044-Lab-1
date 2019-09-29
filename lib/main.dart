import 'package:flutter/material.dart';
 
void main() => runApp(
  MaterialApp(
    title: 'BMR Calc',
    theme:ThemeData(
      primaryColor: Colors.blueAccent,
      accentColor: Colors.blueAccent,
    ),

    home: HomeScreen()
  ),
);

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> gender=["Female","Male"];
  List<String> equation=["Mifflin - St Jeor (default)","Harris - Benedict"];
  List<String> actLevel=["I am sedentary","I am lightly active",
                         "I am moderately active","I am very active","I am super active"];
  String _gender="Female";
  String _equation="Mifflin - St Jeor (default)";
  String _actLevel="I am sedentary";
  String bmr, calories;
  double result=0.0, caloriesday=0.0;
  int _age;
  double _height,_weight;
  String c1,c2,c3,c4,c5;
  double cal1,cal2,cal3,cal4,cal5;

  TextEditingController _ageFieldController = new TextEditingController();
  TextEditingController _heightFieldController = new TextEditingController();
  TextEditingController _weightFieldController = new TextEditingController();

  void selectGender(String value){
    setState((){
      _gender=value;
    });
  }

  void selectEquation(String value){
    setState((){
      _equation=value;
    });
  }

  void selectActLevel(String value){
    setState((){
      _actLevel=value;
    });
  }

  void selectAge(int value){
    setState((){
      _age=value;
    });
  }

  void selectHeight(double value){
    setState((){
      _height=value;
    });
  }

  void selectWeight(double value){
    setState((){
      _weight=value;
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Metric BMR Calculator"),
            elevation: 0.0
          ),
    
          body: ListView(
            children: <Widget>[

            Container(
              child: Column(
                children: <Widget>[

                  Container(
                    child:Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: (
                            Image.asset(
                              'assets/images/bmrlogo.png',
                              width: 180,
                              height: 180
                            )
                        ),
                    ),
                  ),

                  Container(
                      child: Row(
                      children: <Widget>[
                        new Text("  Gender              : ",style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                        new DropdownButton(
                          style: new TextStyle(fontSize: 16.0, color: Colors.black),
                          onChanged: (String value) {
                            selectGender(value);                        },
                            value: _gender,
                            items: gender.map((String value){
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                        ),
                      ],
                    ),
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 0.0),),
                  
                  Container(
                    //padding: EdgeInsets.only(top: 0, left:100),
                      child: Row(
                      children: <Widget>[
                        new Text("  BMR Equation : ",style: new TextStyle(fontSize: 16.0, color: Colors.black)),

                        new DropdownButton(
                          style: new TextStyle(fontSize: 16.0, color: Colors.black),
                          onChanged: (String value) {
                          selectEquation(value);                        },
                          value: _equation,
                          items: equation.map((String value){
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                          );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 0.0),),
                  
                  Container(
                    //padding: EdgeInsets.only(top: 0, left:100),
                      child: Row(
                      children: <Widget>[
                        new Text("  Activity Level   : ",style: new TextStyle(fontSize: 16.0, color: Colors.black)),

                        new DropdownButton(
                          style: new TextStyle(fontSize: 16.0, color: Colors.black),
                          onChanged: (String value) {
                          selectActLevel(value);                        },
                          value: _actLevel,
                          items: actLevel.map((String value){
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                          );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 12.0),),
                  
                  TextField(
                    maxLines: 1,
                    controller: _ageFieldController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(                    
                      hintText: "Age",
                      labelText: "Age",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0.0)
                      ),
                    ),  
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 10.0),),

                  TextField(
                    maxLines: 1,
                    controller: _heightFieldController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Height in cm",
                      labelText: "Height (cm)",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0.0)
                      ),
                    ),  
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 10.0),),

                  TextField(
                    maxLines: 1,
                    controller: _weightFieldController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Weight in kg",
                      labelText: "Weight (kg)",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0.0)
                      ),
                    ),  
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 10.0),),    
                ],
              ),
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: RaisedButton(
                    child: Text("Calculate"),
                    onPressed: _onPress,
                  ), 
                ),
              ],
            ),  

            Text("\n" " BMR Result : ""\n", style: new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold)),
            Text(" For a $_gender of $_age years old with height of ", style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            Text(" $_height cm and weight of $_weight kg ""\n", style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            Text(" Your BMR = $bmr \n Maintenance Calories per day = $calories""\n", style: new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold)),
            Text(" ---------------------------------------------------------------------------------"),
            Text("  Activity Level  \t\t\t         Calories                       ", style: new TextStyle(fontSize: 16.0, color: Colors.black)),                        
            Text(" ---------------------------------------------------------------------------------"),
            Text("  Sedentory                \t\t $c1  calories per day  ", style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            Text("  Lightly active           \t\t $c2  calories per day ", style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            Text("  Moderately active   \t\t $c3  calories per day ", style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            Text("  Very active               \t\t $c4  calories per day ", style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            Text("  Super active             \t\t $c5  calories per day ", style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            Text(" ---------------------------------------------------------------------------------"),
        ],
      ),
    ); 
  }
  
  void _onPress(){
    setState(() {
      int age = int.parse(_ageFieldController.text);
      double height = double.parse(_heightFieldController.text);
      double weight = double.parse(_weightFieldController.text);

      selectAge(age); selectHeight(height); selectWeight(weight);        

      if(_gender == "Female" && _equation == "Mifflin - St Jeor (default)"){
        result = (10*weight) + (6.25*height) - (5*age) - 161;
      }
      else if(_gender == "Female" && _equation == "Harris - Benedict"){
        result = 655.1 + (9.563*weight) + (1.85*height) - (4.676*age);
      }
      else if(_gender == "Male" && _equation == "Mifflin - St Jeor (default)"){
        result = (10*weight) + (6.25*height) - (5*age) - 5;
      }
      else if(_gender == "Male" && _equation == "Harris - Benedict"){
        result = 66.47 + (13.75*weight) + (5.003*height) - (6.755*age);
      }
      else{
        print("Please Enter Your Age, Height and Weight!");
      }

      bmr = format(result);
      cal1=result*1.2; 
      cal2=result*1.375; 
      cal3=result*1.55; 
      cal4=result*1.725; 
      cal5=result*1.9;

      c1 = format(cal1); c2 = format(cal2); c3 = format(cal3);
      c4 = format(cal4); c5 = format(cal5);

      if(_actLevel == "I am sedentary"){
        caloriesday = cal1;
      }
      else if(_actLevel == "I am lightly active"){
        caloriesday = cal2;
      }
      else if(_actLevel == "I am moderately active"){
        caloriesday = cal3;
      }
      else if(_actLevel == "I am very active"){
        caloriesday = cal4;
      }
      else if(_actLevel == "I am super active"){
        caloriesday = cal5;
      }
      else{
        caloriesday = 0.0;
      }
      calories = format(caloriesday);
    });
  }
          
  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 0);
  }             
}





