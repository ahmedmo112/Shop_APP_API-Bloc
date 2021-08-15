
class HomeModel {
  bool? status;
  
  Data? data;

  
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Banners> banners =[];
  List<Products> products=[];
  

  

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class Banners {
  int? id;
  String? image;
  Category? category;
  

  

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
   
    return data;
  }
}

class Category {
  int? id;
  String? image;
  String? name;

  

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}

class Products {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
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
    data['images'] = this.images;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}





























// class HomeModel {
//   bool? status;
//   HomeDataModel? data;

//   HomeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = HomeDataModel.fromJson(json['data']);
//   }
// }

// class HomeDataModel {
//   List<BannerModel> banners = [];
//   List<ProductModel> products = [];

//   HomeDataModel.fromJson(Map<String, dynamic> json) {
//     json['banners'].forEach((element) {
//       banners.add(element);
//     });

//     json['products'].forEach((element) {
//       products.add(element);
//     });
//   }
// }

// class BannerModel {
//   int? id;
//   String? image;
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//   }
// }

// class ProductModel {
//   int? id;
//   dynamic price;
//   dynamic old_price;
//   dynamic discount;
//   String? image;
//   String? name;
//   bool? in_favorites;
//   bool? in_cart;

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     old_price = json['old_price'];
//     image = json['image'];
//     discount = json['discount'];
//     name = json['name'];
//     in_favorites = json['in_favorites'];
//     in_cart = json['in_cart'];
//   }
// }
