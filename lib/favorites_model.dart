import 'data.dart';

class FavoritesModel {
	bool? status;
	dynamic message;
	Data? data;

	FavoritesModel({this.status, this.message, this.data});

	factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
				status: json['status'] as bool?,
				message: json['message'],
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data?.toJson(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		return other is FavoritesModel && 
				other.status == status &&
				other.message == message &&
				other.data == data;
	}

	@override
	int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
