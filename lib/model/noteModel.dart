class Note {
  int _id;
  String _title;
  String _content;
  dynamic _countryid;

  Note(this._title, this._content, this._countryid);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._content = obj['content'];
    this._countryid = obj['countryid'];
  }

  int get id => _id;
  String get title => _title;
  String get content => _content;
  dynamic get countryid => _countryid;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['content'] = _content;
    map['countryid'] = _countryid;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._content = map['content'];
    this._countryid = map['countryid'];
  }
}
