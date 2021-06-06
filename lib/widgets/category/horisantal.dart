import 'package:flutter/material.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/screen/page%20category%20view.dart';
import 'package:syriaonline/service/categoryApi.dart';

class HorisantalListView extends StatefulWidget {
  @override
  _HorisantalListViewState createState() => _HorisantalListViewState();
}

class _HorisantalListViewState extends State<HorisantalListView> {
  List<CategoryModel> categories = [];

  Future<List<CategoryModel>> fdata() async {
    GetCategoryApi cat = GetCategoryApi();
    await cat.getcateg();

    List<CategoryModel> cats = await cat.getcateg();
    categories = cats;
    return categories;
  }

  int selectindex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: fdata(),
      builder: (BuildContext ctx, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.connectionState == null) {
          return Container();
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctx, int index) {
              CategoryModel categoreis = snapshot.data[index];
              return ReusubleTextButton(
                selectindex: selectindex,
                textChild: categoreis.servicesCatogaryName,
                index: index,
                categ: () {
                  setState(() {
                    selectindex = index;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ServiceView(
                            categoryName: categoreis.servicesCatogaryName),
                      ),
                    );
                  });
                },
              );
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
  final int index;
  final int selectindex;

  ReusubleTextButton(
      {@required this.textChild,
      @required this.categ,
      @required this.index,
      @required this.selectindex});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textChild,
                textAlign: TextAlign.center,
                style: selectindex == index
                    ? kTextButtonenable
                    : kTextButtondisable,
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: 5,
                  ),
                  width: 40,
                  height: 2,
                  color:
                      selectindex == index ? Colors.black : Colors.transparent),
            ],
          ),
        ),
        onTap: categ,
      ),
    ]);
  }
}
