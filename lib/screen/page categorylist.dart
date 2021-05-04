import 'package:flutter/material.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/rama/category/category.dart';
// import 'page%20category%20view.dart';
import '../constant/constent.dart';
import '../service/categoryApi.dart';
import '../model/model category .dart';

// ignore: must_be_immutable
class CategoryListPage extends StatelessWidget {
  List<CategoryModel> categories = [];

  Future<List<CategoryModel>> fdata() async {
    GetCategoryApi cat = GetCategoryApi();
    await cat.getcateg();

    List<CategoryModel> cats = await cat.getcateg();
    categories = cats;
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text(
            'Category',
            style: kTitleAppbarStyle,
          )),
      body: Container(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: FutureBuilder<List<CategoryModel>>(
                  future: fdata(),
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<CategoryModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 120),
                        itemBuilder: (BuildContext ctx, int index) {
                          CategoryModel categoreis = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              ///////////////////////////////////for page view///////////////////
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ServiceView(
                                      categoreis.serviceCatogaryId,
                                      categoreis.servicesCatogaryName),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(20),
                              height: 150,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        categoreis.picture,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Text(
                                            categoreis.servicesCatogaryName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: categories.length,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
