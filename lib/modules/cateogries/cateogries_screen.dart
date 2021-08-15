import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/ShopStates.dart';
import 'package:shop_app/layout/cubit/shopCubit.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length
              );
        });
  }

  Widget buildCatItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model!.image.toString()),
               errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 110,
                          width: 110,
                          child: Center(child: CircularProgressIndicator()));
                      },
              width: 110.0,
              height: 110.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              model.name.toString(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
