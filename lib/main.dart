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

  var displayText = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Simple Interest Calculator')),
      body: Container(
          margin: EdgeInsets.all(30.0),
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              TopImage(),
              Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        hintText: 'Enter Prinicipal e.g 50000',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: roiController,
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
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
                          child: TextField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: termController,
                        decoration: InputDecoration(
                            labelText: 'Number of Years',
                            hintText: 'Enter years e.g 5',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                      Container(width: 20.0),
                      Expanded(child: DropDownCurrencies())
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
                            displayText = _calculateInterest(context);
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
                        onPressed: (){
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
          )),
    );
  }

  String _calculateInterest(BuildContext context) {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double amount = principal + (principal * roi * term) / 100;
    String result = 'After $term years, your amount will be $amount';
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayText = "";
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

class DropDownCurrencies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DropDownCurrenciesState();
  }
}

class _DropDownCurrenciesState extends State {
  var _currencies = ['Rupees', 'Dollar', 'Pound'];
  var _selectedCurrency = '';

  @override
  void initState() {
    _selectedCurrency = _currencies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        items: _currencies.map((String currency) {
          return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency, style: Theme.of(context).textTheme.title));
        }).toList(),
        onChanged: (String selectedCurrency) {
          setState(() {
            this._selectedCurrency = selectedCurrency;
          });
        },
        value: _selectedCurrency,
      ),
    );
  }
}
