import 'package:flutter/material.dart';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/service/commentApi.dart';

class PageComment extends StatefulWidget {
  @override
  _PageCommentState createState() => _PageCommentState();
}

class _PageCommentState extends State<PageComment> {
  ////////////////////////////////////////////////////////////////////
  List<CommentModel> comments = [];

  Future<List<CommentModel>> fdata() async {
    GetCommentsApi com = GetCommentsApi();
    await com.getcomment();

    List<CommentModel> coms = await com.getcomment();
    comments = coms;
    return comments;
  }

  void initState() {
    super.initState();
    fdata();
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
            //add comment///////////////
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Comment',
                              filled: true,
                              fillColor: Colors.grey[200],
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                              errorBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.send_outlined),
                                  onPressed: () {
                                    //fordata//////////////////
                                  }),
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                                borderRadius: BorderRadius.circular(25),
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
///////////comment/////////////////
            Container(
              height: MediaQuery.of(context).size.height - 80,
              child: FutureBuilder(
                future: fdata(),
                builder: (BuildContext ctxx,
                    AsyncSnapshot<List<CommentModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 120),
                      itemBuilder: (BuildContext ctx, int index) {
                        CommentModel commentss = snapshot.data[index];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Container(
                                margin: EdgeInsets.only(top: 17),
                                child: Text(commentss.comment),
                              ),
                              subtitle: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(commentss.accountId),
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
          ],
        ),
      ),
    );
  }
}
