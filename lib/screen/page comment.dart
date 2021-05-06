import 'package:flutter/material.dart';
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

  //-------------------------------------get comment----------------------------
  List<RateModel> comments = [];
  Future<List<RateModel>> fdata() async {
    CommentsApi com = CommentsApi();

    List<RateModel> coms = await com.getRate();
    comments = coms;
    return comments;
  }
  //-------------------------------------add comment----------------------------

  addComm(context, Map map) async {
    bool result = await postdata(rate, map);
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),

            //-------------------------------------view comments----------------

            Container(
              height: MediaQuery.of(context).size.height - 80,
              child: FutureBuilder(
                future: fdata(),
                builder: (BuildContext ctxx,
                    AsyncSnapshot<List<RateModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 120),
                      itemBuilder: (BuildContext ctx, int index) {
                        RateModel commentss = snapshot.data[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Container(
                                margin: EdgeInsets.only(top: 17),
                                child: Text(commentss.accountId),
                              ),
                              subtitle: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(commentss.comment),
                                color: Colors.grey[100],
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: comments.length,
                    );
                  }
                },
              ),
            ),
            //--------------------------------add comment-----------------------
            Positioned(
              bottom: 20,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            child: TextFormField(
                              controller: commentController,
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
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.send_outlined),
                                    //----------------comment for data-------------------
                                    onPressed: () {
                                      setState(() {
                                        Map commts = {
                                          'comment': commentController.text,
                                          'service_id': '2',
                                          'account_id': '2',
                                        };
                                        addComm(context, commts);
                                      });
                                    }),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
