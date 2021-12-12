class ChangeFavoritesModel {
  late bool status;
late String message;
  ChangeFavoritesModel.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
