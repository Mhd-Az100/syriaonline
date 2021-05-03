import 'package:flutter/material.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/screen/page%20category%20view.dart';
import 'package:syriaonline/service/get%20category.dart';

class HorisantalListView extends StatelessWidget {
  List<CategoryModel> categories = [];

  Future<List<CategoryModel>> fdata() async {
    GetCategory cat = GetCategory();
    await cat.getcateg();

    List<CategoryModel> cats = await cat.getcateg();
    categories = cats;
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: FutureBuilder<List<CategoryModel>>(
        future: fdata(),
        builder:
            (BuildContext ctx, AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(child: Center(child: CircularProgressIndicator()));
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 120),
              itemBuilder: (BuildContext ctx, int index) {
                CategoryModel categoreis = snapshot.data[index];
                return ReusubleTextButton(
                    textChild: categoreis.servicesCatogaryName,
                    categ: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ServiceView(
                              categoreis.serviceCatogaryId,
                              categoreis.servicesCatogaryName),
                        ),
                      );
                    });
              },
              itemCount: categories.length,
            );
          }
        },
      ),

      //   child: ListView(
      //     scrollDirection: Axis.horizontal,
      //     children: [
      //       ReusubleTextButton(textChild: 'Hotels', categ: () {}),
      //       ReusubleTextButton(textChild: 'Restaurants', categ: () {}),
      //       ReusubleTextButton(textChild: 'Hospitals', categ: () {}),
      //       ReusubleTextButton(textChild: 'Pharmacies', categ: () {}),
      //       ReusubleTextButton(textChild: 'Schools', categ: () {}),
      //       ReusubleTextButton(textChild: 'Centers', categ: () {}),
      //     ],
      //   ),
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
          ),
          onPressed: categ,
          fillColor: Color(0xFFDFDFDF),
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
