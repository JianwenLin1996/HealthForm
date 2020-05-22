import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../record/database_helper.dart';
import '../record/record.dart';
import '../globals.dart' as globals;

class HealthScoreStat extends StatefulWidget {
  @override
  _HealthScoreStatState createState() => _HealthScoreStatState();
}

class _HealthScoreStatState extends State<HealthScoreStat> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Record> _recordList;
  Record _record = Record("", "", "", globals.finalScore);

  TextEditingController _name = new TextEditingController();
  TextEditingController _description = new TextEditingController();

  bool _validatename = false; //false when no error
  bool _validatedescription = false; //false when no error

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_recordList == null) {
      _recordList = List<Record>();
    }

    return SingleChildScrollView(
      child: new Container(
        child: new Center(
            child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                textfield(_name, "Name", _validatename),
                textfield(_description, "Comment", _validatedescription),
                RaisedButton(
                    color: Colors.greenAccent,
                    child: new Text(
                      "Save",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    onPressed: () {
                      _name.text.length < 1
                          ? _validatename = true
                          : _validatename = false;
                      _description.text.length < 1
                          ? _validatedescription = true
                          : _validatedescription = false;
                      setState(() {
                        print("save");
                      });
                      (_validatedescription == false && _validatename == false)
                          ? save()
                          : null;
                    })
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            healthstatrow(1),
            healthstatrow(2),
            healthstatrow(3),
            healthstatrow(4)
          ],
        )),
      ),
    );
  }

  void updateScore() {
      _record.score = globals.finalScore; // declare _record first to avoid error
      //NoSuchMethodError: The setter 'date=' was called on null.
  }

  void save() async {
    updateScore();
    int result;
    _record.date = DateTime.now().day.toString() +
        "/" +
        DateTime.now().month.toString() +
        "/" +
        DateTime.now().year.toString();
    result = await _databaseHelper.insertRecord(_record);
    if (result != 0){
      final snackBar = SnackBar(content: Text("Saved successfully"));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text("Fail to save."));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void updateTitle() {
    _record.name = _name.text;
    _record.description = _description.text;
  }

Widget textfield(TextEditingController controller, String hint, bool validate) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
      child: TextField(
        decoration: new InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
          ),
          labelText: hint,
          errorText: validate
              ? "Do not leave blank."
              : null, //if put false, border will become red. MUST put null
        ),
        onChanged: (String input) {
          controller.value.copyWith(
              text: input,
              selection: TextSelection(
                  baseOffset: input.length, extentOffset: input.length));
          updateTitle();
        },
        controller: controller,
      ),
    ),
  );
}
}

Widget healthstatrow(int rownumber) {
  return new Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      sphere(3 * rownumber - 3),
      sphere(3 * rownumber - 2),
      sphere(3 * rownumber - 1)
    ],
  );
}

Widget sphere(int index) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
    child: Container(
      height: globals.screenheight * 0.2,
      width: globals.screenwidth * 0.25,
      decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              offset: new Offset(5.0, 5.0),
              blurRadius: 10.0,
            )
          ],
          border: Border.all(
              width: 3.0,
              color: globals.finalScore[index] < 15
                  ? Colors.green
                  : globals.finalScore[index] < 30
                      ? Colors.yellow
                      : Colors.red),
          shape: BoxShape.circle),
      child: new CircleAvatar(
          backgroundColor: Colors.blue[50],
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  globals.nutrientname[index],
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                new Text(
                  globals.finalScore[index].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.black),
                )
              ])),
    ),
  );
}


