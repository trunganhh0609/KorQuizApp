class Q {
  String? qUESTIONTEXT;
  List<ANSWER>? aNSWER;
  String? qUESTIONTYPE;
  int? qUESTIONID;

  Q({this.qUESTIONTEXT, this.aNSWER, this.qUESTIONTYPE, this.qUESTIONID});

  Q.fromJson(Map<String, dynamic> json) {
    qUESTIONTEXT = json['QUESTION_TEXT'];
    if (json['ANSWER'] != null) {
      aNSWER = <ANSWER>[];
      json['ANSWER'].forEach((v) {
        aNSWER!.add(new ANSWER.fromJson(v));
      });
    }
    qUESTIONTYPE = json['QUESTION_TYPE'];
    qUESTIONID = json['QUESTION_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QUESTION_TEXT'] = this.qUESTIONTEXT;
    if (this.aNSWER != null) {
      data['ANSWER'] = this.aNSWER!.map((v) => v.toJson()).toList();
    }
    data['QUESTION_TYPE'] = this.qUESTIONTYPE;
    data['QUESTION_ID'] = this.qUESTIONID;
    return data;
  }
}

class ANSWER {
  int? aNSWERID;
  double? aNSWERCORRECT;
  int? qUESTIONID;
  String? aNSWERTEXT;
  int? aNSWERORDINAL;

  ANSWER(
      {this.aNSWERID,
      this.aNSWERCORRECT,
      this.qUESTIONID,
      this.aNSWERTEXT,
      this.aNSWERORDINAL});

  ANSWER.fromJson(Map<String, dynamic> json) {
    aNSWERID = json['ANSWER_ID'];
    aNSWERCORRECT = json['ANSWER_CORRECT'];
    qUESTIONID = json['QUESTION_ID'];
    aNSWERTEXT = json['ANSWER_TEXT'];
    aNSWERORDINAL = json['ANSWER_ORDINAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ANSWER_ID'] = this.aNSWERID;
    data['ANSWER_CORRECT'] = this.aNSWERCORRECT;
    data['QUESTION_ID'] = this.qUESTIONID;
    data['ANSWER_TEXT'] = this.aNSWERTEXT;
    data['ANSWER_ORDINAL'] = this.aNSWERORDINAL;
    return data;
  }
}
