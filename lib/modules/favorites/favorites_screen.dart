import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/ShopStates.dart';
import 'package:shop_app/layout/cubit/shopCubit.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is! ShopLoadingGetFavDataState
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFavItem(
                      ShopCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data![index]
                          .product,
                      context),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount:
                      ShopCubit.get(context).favoritesModel!.data!.data!.length)
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget buildFavItem(Product? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 100.0,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    image: NetworkImage(model!.image.toString()),
                     errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          width: 100,
                          child: Center(child: CircularProgressIndicator()));
                      },
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover),
                if (model.discount != 0)
                  Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8.0, color: Colors.white),
                      ))
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(fontSize: 12.0, color: defultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).fav[model.id]!
                                    ? Colors.red
                                    : Colors.grey,
                            radius: 15.0,
                            child: Icon(Icons.favorite_border,
                                size: 14, color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      );
}
