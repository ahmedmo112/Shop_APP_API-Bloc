import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shopCubit.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/searchCubit.dart';
import 'package:shop_app/modules/search/cubit/searchStatus.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'enter text to search';
                          }
                        },
                        onSubmit: (v) {
                          SearchCubit.get(context).serch(v);
                        },
                        label: 'Search',
                        prefix: Icons.search,
                      ),
                      SizedBox(height: 10,),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) => buildSearchItem(
                        SearchCubit.get(context).model!.data!.data![index],
                        context),
                                        separatorBuilder: (context, index) => Divider(),
                                        itemCount:
                        SearchCubit.get(context).model!.data!.data!.length),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
  Widget buildSearchItem(Product? model, context) => Padding(
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
                    fit: BoxFit.cover
                    ),
                
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
                     
                      // Spacer(),
                      // IconButton(
                      //     onPressed: () {
                      //    //*    ShopCubit.get(context).changeFavorites(model.id!);
                      //     },
                      //     icon: CircleAvatar(
                      //       backgroundColor:
                      //           ShopCubit.get(context).fav[model.id]!
                      //               ? Colors.red
                      //               : Colors.grey,
                      //       radius: 15.0,
                      //       child: Icon(Icons.favorite_border,
                      //           size: 14, color: Colors.white),
                      //     )),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      );
}
