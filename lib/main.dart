import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Simple Interest Calcuclator',
      home: SiForm(),
    ));

class SiForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SiFormState();
  }
}

class _SiFormState extends State {
  @override
  Widget build(BuildContext context) {
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
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        hintText: 'Enter Prinicipal e.g 50000',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: 'Enter Rate of Interest e.g 10',
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
                        decoration: InputDecoration(
                            labelText: 'Number of Years',
                            hintText: 'Enter years e.g 5',
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
                        color: Colors.deepPurple,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20.0, decoration: TextDecoration.none,
                              color: Colors.white)
                        ),
                        elevation: 6.0,
                        onPressed: () => calculateInterest(context),
                      ),
                    ),
                    Container( width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.deepPurple,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              fontSize: 20.0, decoration: TextDecoration.none,
                          color: Colors.white),
                        ),
                        elevation: 6.0,
                        onPressed: () => calculateInterest(context),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                    'text',
                  textAlign: TextAlign.center
                ),
              )
            ],
          )),
    );
  }
}

void calculateInterest(BuildContext context) {

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
  var _selectedCurrency = 'Rupees';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        items: _currencies.map((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Container(
              child: Row(
                children: <Widget>[Icon(Icons.arrow_right), Text(currency)],
              ),
            ),
          );
        }).toList(),
        onChanged: (String selectedCurrency) {
          this._selectedCurrency = selectedCurrency;
        },
        value: _selectedCurrency,
      ),
    );
  }
}
