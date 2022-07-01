class Test {
  int? RESULT_ID;
  int? USER_ID;
  String? TIME;
  String? SUBMIT_AT;
  double? POINT;
  String? TYPE;
  int? NUM_QUEST;

  Test(
      {this.RESULT_ID,
        this.USER_ID,
        this.TIME,
        this.SUBMIT_AT,
        this.POINT,
        this.TYPE,
        this.NUM_QUEST});

  Test.fromJson(Map<String, dynamic> json) {
    RESULT_ID = json['RESULT_ID'];
    USER_ID = json['USER_ID'];
    TIME = json['TIME'];
    SUBMIT_AT = json['SUBMIT_AT'];
    POINT = json['POINT'];
    TYPE = json['TYPE'];
    NUM_QUEST = json['NUM_QUEST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RESULT_ID'] = this.RESULT_ID;
    data['USER_ID'] = this.USER_ID;
    data['TIME'] = this.TIME;
    data['SUBMIT_AT'] = this.SUBMIT_AT;
    data['POINT'] = this.POINT;
    data['TYPE'] = this.TYPE;
    data['NUM_QUEST'] = this.NUM_QUEST;
    return data;
  }
}