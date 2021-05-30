class Notes {
  int _id;
  String _title;
  String _description;
  String _date;
  int _color;

  Notes(this._id, this._title, this._description, this._date, this._color);
  Notes.addNotes(this._title, this._description, this._date, this._color);

  int get color => _color;

  String get date => _date;
  String get description => _description;
  String get title => _title;
  int get id => _id;

  @override
  String toString() {
    return 'Notes{_title: $_title, _description: $_description, _date: $_date, _color: $_color}';
  }

  //Convert a Notes object into a Map objects
  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "title": _title,
      "description": _description,
      "date": _date,
      "color": _color
    };
  }

  //Convert a Map object into Notes objects
  factory Notes.fromMap(Map<String, dynamic> json) => Notes(json["id"],
      json["title"], json["description"], json["date"], json["color"]);
}
