import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/ShopStates.dart';
import 'package:shop_app/layout/cubit/shopCubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      //! if state is false or token unknown
      if (state is ShopSuccessChangeFavDataState) {
        if (!state.model.status!) {
          showToast(
              text: state.model.message.toString(), state: ToastStates.ERROR);
        }
      }
    }, builder: (context, state) {
      return ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null
          ? productBuilder(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel, context)
          : Center(child: CircularProgressIndicator());
    });
  }

  Widget productBuilder(
      HomeModel? model, CategoriesModel? categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()));
                      },
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoriesItem(
                          categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel!.data!.data.length),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.6,
                children: List.generate(
                    model.data!.products.length,
                    (index) => buildGridProduct(
                        model.data!.products[index], context))),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItem(DataModel? model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
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
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            width: 100.0,
            child: Text(
              model.name.toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  Widget buildGridProduct(Products? model, context) => Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.image.toString()),
                errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 170,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()));
                      },
                height: 170.0,
                width: double.infinity,
              ),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(fontSize: 12.0, color: defultColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).fav[model.id]!
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
      );
}
