class Product {
	int? id;
	int? price;
	int? oldPrice;
	int? discount;
	String? image;
	String? name;
	String? description;

	Product({
		this.id, 
		this.price, 
		this.oldPrice, 
		this.discount, 
		this.image, 
		this.name, 
		this.description, 
	});

	factory Product.fromJson(Map<String, dynamic> json) => Product(
				id: json['id'] as int?,
				price: json['price'] as int?,
				oldPrice: json['old_price'] as int?,
				discount: json['discount'] as int?,
				image: json['image'] as String?,
				name: json['name'] as String?,
				description: json['description'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'price': price,
				'old_price': oldPrice,
				'discount': discount,
				'image': image,
				'name': name,
				'description': description,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		return other is Product && 
				other.id == id &&
				other.price == price &&
				other.oldPrice == oldPrice &&
				other.discount == discount &&
				other.image == image &&
				other.name == name &&
				other.description == description;
	}

	@override
	int get hashCode =>
			id.hashCode ^
			price.hashCode ^
			oldPrice.hashCode ^
			discount.hashCode ^
			image.hashCode ^
			name.hashCode ^
			description.hashCode;
}
