class CategoriesModel {
  bool? status;
 late CategoriesModelData data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // data = CategoriesModelData.fromJson(json['data']);

    data = (json['data'] != null
        ? new CategoriesModelData.fromJson(json['data'])
        : null)!;
  }
}

class CategoriesModelData {
  // int? currentPage;
   List<DataModel> data=[];
  CategoriesModelData.fromJson(Map<String, dynamic> json) {
    // currentPage = json['currentPage'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(
       new  DataModel.fromJson(element),
        );
      });
    }
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
