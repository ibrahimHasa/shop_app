import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/state_management/cubit/shop_cubit.dart';
import 'package:souq/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildItem(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data.data.length);
      },
      listener: (context, state) {},
    );
  }

  Widget buildItem(DataModel model) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
          SizedBox(
            width: 22,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
