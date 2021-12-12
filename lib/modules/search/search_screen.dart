import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/state_management/search_cubit/cubit.dart';
import 'package:souq/layout/state_management/search_cubit/states.dart';
import 'package:souq/models/favourites_model.dart';
import 'package:souq/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Emter text to search';
                          }
                        },
                        onFieldSubmitted: (text) {
                          SearchCubit.get(context).search(text);
                        },
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                        if(state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                                      itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data.data[index
                                      ],context,isOldPrice:false),
                                      separatorBuilder: (context, index) => myDivider(),
                                      itemCount:
                                          SearchCubit.get(context).model!.data.data.length),
                        ),
                  
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
  
}
