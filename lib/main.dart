import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Simple Interest Calcuclator',
      debugShowCheckedModeBanner: false,
      home: SiForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent),
    ));

class SiForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SiFormState();
  }
}

class _SiFormState extends State {
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollar', 'Pound'];
  var _selectedCurrency = '';

  var displayText = "";

  @override
  void initState() {
    _selectedCurrency = _currencies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Simple Interest Calculator')),
      body: Form(
          // Using this key we can get the instance of the form
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(30.0),
              child: ListView(
                children: <Widget>[
                  TopImage(),
                  Padding(
                      padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: principalController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            displayText = '';
                            return 'Please enter Prinicipal';
                          }
                          if (!isNumeric(value)) {
                            displayText = '';
                            return 'Please enter a numeric value';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Principal',
                            hintText: 'Enter Prinicipal e.g 50000',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: roiController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            displayText = '';
                            return 'Please enter Rate of Interest';
                          }
                          if (!isNumeric(value)) {
                            displayText = '';
                            return 'Please enter a numeric value';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Rate of Interest',
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 15),
                            hintText: 'Enter Rate of Interest e.g 10',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: termController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                displayText = '';
                                return 'Please enter number of years';
                              }
                              if (!isNumeric(value)) {
                                displayText = '';
                                return 'Please enter a numeric value';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Number of Years',
                                hintText: 'Enter years e.g 5',
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15),
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                          Container(width: 20.0),
                          Expanded(
                              child: Container(
                            child: DropdownButton<String>(
                              items: _currencies.map((String currency) {
                                return DropdownMenuItem<String>(
                                    value: currency,
                                    child: Text(currency,
                                        style:
                                            Theme.of(context).textTheme.title));
                              }).toList(),
                              onChanged: (String selectedCurrency) {
                                setState(() {
                                  this._selectedCurrency = selectedCurrency;
                                });
                              },
                              value: _selectedCurrency,
                            ),
                          ))
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              'Submit',
                              textScaleFactor: 1.5,
                            ),
                            elevation: 6.0,
                            onPressed: () {
                              setState(() {
                                // checks all the validation in the form for the current state
                                if (_formKey.currentState.validate()) {
                                  displayText = _calculateInterest(context);
                                }
                              });
                            },
                          ),
                        ),
                        Container(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            elevation: 6.0,
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(displayText, textAlign: TextAlign.center),
                  )
                ],
              ))),
    );
  }

  String _calculateInterest(BuildContext context) {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double amount = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your amount will be $_selectedCurrency $amount';
    return result;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayText = "";
    _selectedCurrency = _currencies[0];
  }
}

class TopImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/image.png');
    Image image = Image(
      image: assetImage,
      width: 200,
      height: 200,
    );
    return Container(child: image);
  }
}
