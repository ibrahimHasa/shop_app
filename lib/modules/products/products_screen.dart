import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/state_management/cubit/shop_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:souq/models/categories_model.dart';
import 'package:souq/models/home_model.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopCubit>(context)..getCategories(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSuccessChangeFavoritesState) {
            if (!state.model.status) {
              showToast(text: state.model.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => HomeBuilder(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget HomeBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    viewportFraction: 1),
                items: model!.data.banners.map((e) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          child: Image(
                            image: NetworkImage(
                              '${e.image}',
                            ),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildCategoryItem(categoriesModel, index),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 3,
                  ),
                  itemCount: categoriesModel!.data.data.length,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                color: Colors.grey[200],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.1 / 2,
                  children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget buildCategoryItem(CategoriesModel? model, index) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${model!.data.data[index].image}'),
              height: 100,
              width: 100,
              // fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(2),
              color: Colors.black.withOpacity(.5),
              width: 100,
              child: Text(
                '${model.data.data[index].name}',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(Products model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  // fit: BoxFit.cover,
                  width: double.infinity,
                  height: 170,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '${model.name}',
                style: TextStyle(
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    '${model.price} ',
                    style: TextStyle(fontSize: 15, color: defaultColor),
                    // maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  if (model.discount != 0)
                    Text(
                      '${model.old_price}',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                    icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            // ShopCubit.get(context).favourites[model.id]??false
                            ShopCubit.get(context).favourites[model.id] ?? false
                                ? defaultColor
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 15,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
