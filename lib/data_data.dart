import 'product.dart';

class Data {
	int? id;
	Product? product;

	Data({this.id, this.product});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				product: json['product'] == null
						? null
						: Product.fromJson(json['product'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'product': product?.toJson(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		return other is Data && 
				other.id == id &&
				other.product == product;
	}

	@override
	int get hashCode => id.hashCode ^ product.hashCode;
}
