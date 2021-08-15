class SearchModel 
{
  bool? status;
  Null message;
  Data? data;
  
  SearchModel.fromJson(Map<String, dynamic> json) 
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data =[];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}


class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
































// class FavoritesModel {
//   bool? status;
//   FavoritesModelData? data;

//   FavoritesModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     data = (json["data"] != null)
//         ? FavoritesModelData.fromJson(json["data"])
//         : null;
//   }
// }

// class FavoritesModelData {
//   int? currentPage;
//   List<FavoritesModelDataData?>? data;

//   FavoritesModelData.fromJson(Map<String, dynamic> json) {
//     currentPage = json["current_page"]?.toInt();
//     if (json["data"] != null) {
//       final v = json["data"];
//       final arr0 = <FavoritesModelDataData>[];
//       v.forEach((v) {
//         arr0.add(FavoritesModelDataData.fromJson(v));
//       });
//       this.data = arr0;
//     }
//   }
// }

// class FavoritesModelDataData {
//   int? id;
//   FavoritesModelDataDataProduct? product;

//   FavoritesModelDataData.fromJson(Map<String, dynamic> json) {
//     id = json["id"]?.toInt();
//     product = (json["product"] != null)
//         ? FavoritesModelDataDataProduct.fromJson(json["product"])
//         : null;
//   }
// }

// class FavoritesModelDataDataProduct {
//   int? id;
//   int? price;
//   int? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;

//   FavoritesModelDataDataProduct.fromJson(Map<String, dynamic> json) {
//     id = json["id"]?.toInt();
//     price = json["price"]?.toInt();
//     oldPrice = json["old_price"]?.toInt();
//     discount = json["discount"]?.toInt();
//     image = json["image"]?.toString();
//     name = json["name"]?.toString();
//     description = json["description"]?.toString();
//   }
// }


