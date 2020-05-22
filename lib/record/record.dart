class Record {

  int _id;
  String _name;
  String _description;
  String _date;
  List<int> _score = List<int>();

  Record(this._name,this._description,this._date,this._score);
  Record.withId(this._id,this._name,this._description,this._date,this._score);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get date => _date;
  List<int> get score => _score;

  set name (String newName){
    this._name = newName;
  }

  set description (String newDescription){
    this._description = newDescription;
  }

  set date (String newDate){
    this._date = newDate;
  }

  set score (List<int> newScore){
    this._score = newScore;
  }

  //convert a record object to a map object
  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    if (id !=null) map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['date'] = _date;
    for (int i=0; i<12; i++)
    {map['s${i+1}'] = _score[i];}

    return map;
  }

  //extract a record object from a map object
  Record.fromMapObject(Map<String,dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._description = map['description'];
    this._date = map['date'];
    for (int i=0; i<12; i++)
    {
      this._score.add(map['s${i+1}']);}
    
  }

}