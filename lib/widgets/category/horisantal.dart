import 'package:flutter/material.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/screen/page%20category%20view.dart';
import 'package:syriaonline/service/categoryApi.dart';

class HorisantalListView extends StatelessWidget {
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
    return FutureBuilder<List<CategoryModel>>(
      future: fdata(),
      builder: (BuildContext ctx, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctx, int index) {
              CategoryModel categoreis = snapshot.data[index];
              return ReusubleTextButton(
                  textChild: categoreis.servicesCatogaryName,
                  categ: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ServiceView(
                            id: categoreis.serviceCatogaryId,
                            categoryName: categoreis.servicesCatogaryName),
                      ),
                    );
                  });
            },
            itemCount: categories.length,
          );
        }
      },
    );
  }
}

class ReusubleTextButton extends StatelessWidget {
  final Function categ;
  final String textChild;
  ReusubleTextButton({@required this.textChild, @required this.categ});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 110,
        child: RawMaterialButton(
          child: Text(
            textChild,
            textAlign: TextAlign.center,
            style: kTextButton,
          ),
          onPressed: categ,
          fillColor: kButtonLstcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      SizedBox(
        width: 10.0,
      )
    ]);
  }
}
