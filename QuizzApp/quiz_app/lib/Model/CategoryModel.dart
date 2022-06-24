class CategoryModel {
  int? CATEGORYID;
  String? CATEGORYTITLE;

  CategoryModel({this.CATEGORYID, this.CATEGORYTITLE});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    CATEGORYID = json['CATEGORY_ID'];
    CATEGORYTITLE = json['CATEGORY_TITLE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CATEGORY_ID'] = this.CATEGORYID;
    data['CATEGORY_TITLE'] = this.CATEGORYTITLE;
    return data;
  }
}
