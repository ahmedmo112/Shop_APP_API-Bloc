class ShopLoginModel {
   bool? status;
   String? message;
  UserData? data;

  ShopLoginModel.fromjson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data =  UserData.fromjson(json['data']);
  }
}


class UserData {
  int? id ;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  

  UserData.fromjson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }


}
