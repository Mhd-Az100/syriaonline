import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/provider/providerData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/service/commentApi.dart';
import 'package:syriaonline/service/postApi.dart';
import 'package:syriaonline/utils/allUrl.dart';

class PageComment extends StatefulWidget {
  @override
  _PageCommentState createState() => _PageCommentState();
}

class _PageCommentState extends State<PageComment> {
  TextEditingController commentController = TextEditingController();
  final commentformKey = new GlobalKey<FormState>();

  String commented;
  String id;
  void initState() {
    super.initState();
    id = Provider.of<Providerdata>(context, listen: false)
        .service
        .serviceId
        .toString();

    fdata();
    getpref();
  }

  //---------------------------refearsh-----------------------------------------
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  ScrollController _scrollController;
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      _scaffoldKey.currentState;
      setState(() {
        initState();
      });
    });
  }
  //-------------------------------------get id user----------------------------

  var iduser;

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      iduser = preferences.getString('account_id');
    });
  }
  //-------------------------------------get img from device--------------------

  File _file;
  final picker = ImagePicker();

  Future getImage(x) async {
    final pickedFile = await picker.getImage(source: x);

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadimg() async {
    if (_file == null) return;
    String base64 = base64Encode(_file.readAsBytesSync());
    String imgname = _file.path.split('/').last;
    print(base64);
    print(imgname);
  }

  //-------------------------------------get comment----------------------------
  List<CommentModel> comments = [];
  Future<List<CommentModel>> fdata() async {
    GetCommentsApi com = GetCommentsApi(id: id);
    List<CommentModel> coms = await com.getRate();
    comments = coms;
    return comments;
  }

  //-------------------------------------add comment----------------------------

  addComm(context, Map map) async {
    bool result = await postdata(comment, map);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: LiquidPullToRefresh(
          springAnimationDurationInMilliseconds: 200,
          color: Colors.transparent,
          backgroundColor: kchooseColor,
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          showChildOpacityTransition: true,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),

              //-------------------------------------view comments----------------

              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                color: Colors.white,
                height: MediaQuery.of(context).size.height - 31,
                child: FutureBuilder(
                  future: fdata(),
                  builder: (BuildContext ctxx,
                      AsyncSnapshot<List<CommentModel>> snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 120),
                        itemCount: comments.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          CommentModel commentss = snapshot.data[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                    commentss.account.picture,
                                  ),
                                ),
                                title: Container(
                                  margin: EdgeInsets.only(top: 17),
                                  child: Text(commentss.account.firstName +
                                      " " +
                                      commentss.account.lastName),
                                ),
                                subtitle: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(commentss.comment),
                                      color: Colors.grey[100],
                                    ),
                                    if (commentss.picture != null)
                                      Image.network(
                                        commentss.picture,
                                        fit: BoxFit.cover,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              //--------------------------------add comment-----------------------
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.transparent,
                  height: 85,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Form(
                                key: commentformKey,
                                child: TextFormField(
                                  controller: commentController,
                                  validator: (val) => val.length == 0
                                      ? 'your not commented'
                                      : null,
                                  onSaved: (val) => commented = val,
                                  decoration: InputDecoration(
                                    hintText: 'Comment',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide:
                                          BorderSide(style: BorderStyle.none),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide:
                                          BorderSide(style: BorderStyle.none),
                                    ),
                                    errorBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              "img/icons/image.svg",
                              width: 40,
                            ),
                            onPressed: () => getImage(ImageSource.gallery),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(5.0),
                              child: _file == null
                                  ? Container()
                                  : Image.file(_file),
                            ),
                          ),
                          IconButton(
                              icon: SvgPicture.asset(
                                "img/icons/send.svg",
                                width: 60,
                              ),
                              //----------------comment for data-------------------
                              onPressed: () {
                                // ---------map data---------------
                                if (_file != null) {
                                  String base64 =
                                      base64Encode(_file.readAsBytesSync());
                                  String imgname = _file.path.split('/').last;

                                  Map commts = {
                                    'comment': commentController.text,
                                    'service_id': id,
                                    'account_id': iduser.toString(),
                                    'imgname': imgname,
                                    'base64': base64,
                                  };

                                  if (commentformKey.currentState.validate()) {
                                    setState(() {
                                      addComm(context, commts);
                                    });
                                    commentController.text = '';
                                    _file = null;
                                    print(commts);
                                  }
                                } else {
                                  Map commts = {
                                    'comment': commentController.text,
                                    'service_id': id,
                                    'account_id': iduser.toString(),
                                  };

                                  if (commentformKey.currentState.validate()) {
                                    setState(() {
                                      addComm(context, commts);
                                    });

                                    commentController.text = '';
                                    _file = null;
                                    print(commts);
                                  }
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
