class HomeModel {
  late bool status;
  late HomeModelData data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? new HomeModelData.fromJson(json['data']) : null)!;
  }
}

class HomeModelData {
  List<Banners> banners = [];
  List<Products> products = [];
  HomeModelData.fromJson(Map<String, dynamic> json) {
    // json['banners'].forEach((e) {
    //   banners.add(e);
    // });
    // json['products'].forEach((e) {
    //   products.add(e);
    // });
    if (json['banners'] != null) {
      json['banners'].forEach((e) {
        banners.add(new Banners.fromJson(e));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((e) {
        products.add(new Products.fromJson(e));
      });
    }
  }
}

class Banners {
  late int id;
  late String image;
  late String category;
  late String product;
  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class Products {
  late int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
