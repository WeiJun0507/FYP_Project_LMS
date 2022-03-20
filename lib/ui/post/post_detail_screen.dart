import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_lms/controller/post/post_detail_controller.dart';
import 'package:fyp_lms/utils/custom_field/common/attachment_comment.dart';
import 'package:fyp_lms/utils/date_util.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constant.dart';
import '../../utils/general_utils.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PostDetailController controller = PostDetailController();
  late SharedPreferences _sPref;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.isLoading = true;
    });
    SharedPreferences.getInstance().then((value) {
      setState(() {
        _sPref = value;
        initializeData();

      });
    });
  }

  initializeData() async {
    //_sPref.setString('accountInfo', jsonEncode(createdUser));
    controller.accountId = _sPref.getString('account');
    controller.accountName = _sPref.getString('username');
    controller.user = Account.fromJson(jsonDecode(_sPref.getString('accountInfo')!));
    controller.accountType = _sPref.getInt('accountType');

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
      if (arguments['post'] != null) {
        setState(() {
          controller.post = arguments['post'];

        });
      }
      if (arguments['isLiked'] != null) {
        setState(() {
          controller.isLiked = arguments['isLiked'];

        });
      }
    });
    setState(() {
      controller.isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 400),
                height: controller.isLoading ? 0 : MediaQuery.of(context).size.height,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: MediaQuery.of(context).size.height * 0.3,
                        floating: false,
                        pinned: true,
                        elevation: 0,
                        leadingWidth: 56,
                        leading: Icon(
                          Icons.arrow_back,
                          color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]),
                        ).onTap(() => Navigator.of(context).pop()),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {

                            },
                          )
                        ],
                        centerTitle: true,
                        title: Column(
                          children: <Widget>[
                            //COURSE TITLE
                            Text(controller.post!.title ?? '-', style: GoogleFonts.poppins().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)])
                            ),),
                            //COURSE CODE
                            Text(controller.post!.courseBelonging!, style: GoogleFonts.poppins().copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]),
                            ),),
                          ],
                        ),
                        backgroundColor: controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)].withOpacity(0.8),
                        flexibleSpace: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return FlexibleSpaceBar(
                              background: Container(
                                margin: EdgeInsets.only(top: constraints.maxHeight *  0.35),
                                child: Column(
                                  children: <Widget>[
                                    //DISPLAY POST
                                    Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(GeneralUtil().getShortName(controller.post!.createdByName ?? 'A').toUpperCase(), style: GoogleFonts.poppins().copyWith(
                                        fontSize: BIG_TITLE,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),),
                                    ),

                                    //ROW DISPLAYED
                                    Container(
                                      margin: const EdgeInsets.only(top: large_padding),
                                      child: Row(
                                        children: <Widget>[
                                          //DATE
                                          Expanded(
                                            child: Container(
                                                margin: const EdgeInsets.only(left: large_padding, right: large_padding),
                                                padding: const EdgeInsets.only(left: large_padding, right: large_padding, top: normal_padding, bottom: normal_padding),
                                              decoration: BoxDecoration(
                                                color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]) == Colors.white ? Colors.white10 : Colors.black12,
                                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Created Date:', style: GoogleFonts.poppins().copyWith(
                                                    color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]),
                                                    fontSize: SUB_TITLE,
                                                    fontWeight: FontWeight.w500,
                                                  ),),
                                                  Text(DateUtil().getDatetimeFormatDisplay().format(DateTime.parse(controller.post!.createdDate!)),style: GoogleFonts.poppins().copyWith(
                                                    color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]),
                                                    fontWeight: FontWeight.w600,
                                                  ),),
                                                ],
                                              )
                                            ),
                                          ),

                                          //POST TYPE
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(left: large_padding, right: large_padding),
                                                padding: const EdgeInsets.only(left: large_padding, right: large_padding, top: normal_padding, bottom: normal_padding),
                                                decoration: BoxDecoration(
                                                  color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]) == Colors.white ? Colors.white10 : Colors.black12,
                                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Post Type:', style: GoogleFonts.poppins().copyWith(
                                                      color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]),
                                                      fontSize: SUB_TITLE,
                                                      fontWeight: FontWeight.w500,
                                                    ),),
                                                    Text(controller.post!.type!,style: GoogleFonts.poppins().copyWith(
                                                      color: GeneralUtil().getTextColor(controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)]),
                                                      fontWeight: FontWeight.w600,
                                                    ),),
                                                  ],
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ]
                                ),
                              ),
                            );
                          }
                        ),

                      )
                    ];
                  },
                  body: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //ANNOUNCEMENT
                        Container(
                          padding: const EdgeInsets.all(large_padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.category,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                  ),

                                  Text('Post Notes > ',
                                      style: GoogleFonts.poppins().copyWith(
                                          fontSize: SUB_TITLE,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),

                              Container(
                                margin: const EdgeInsets.all(normal_padding),
                                child: Text(controller.post!.notes!,
                                    style: GoogleFonts.poppins().copyWith(
                                        fontWeight: FontWeight.w500)),
                              ),

                            ],
                          ),
                        ),

                        //COURSE BELONGING
                        Container(
                          margin: EdgeInsets.only(left: x_large_padding, right: x_large_padding),
                          //padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: controller.colorSelectionColor[controller.colorSelection.indexOf(controller.post!.color!)],
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), topLeft: Radius.circular(6))
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: normal_padding, bottom: normal_padding, left: large_padding),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Course Belongs To:',style: GoogleFonts.poppins().copyWith(
                                                fontSize: SUB_TITLE,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                              Text(controller.post!.courseBelonging!, style: GoogleFonts.poppins().copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(right: 12),
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ).onTap(() {
                          Navigator.of(context).pushNamed('/CourseDetailScreen', arguments: {
                            'courseId': controller.post!.courseBelonging,
                          });
                        }),
                        SizedBox(height: 10),

                        //ATTACHMENTS
                        Container(
                          padding: const EdgeInsets.all(large_padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.category,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                  ),

                                  Text('Post Attachments > ',
                                      style: GoogleFonts.poppins().copyWith(
                                          fontSize: SUB_TITLE,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),

                              Container(
                                margin: const EdgeInsets.all(normal_padding),
                                height: 75.0,
                                child: attachmentComment(context, controller.post!.attachments),
                              ),
                            ],
                          ),
                        ),

                        Divider(
                          height: 10,
                          thickness: 10,
                          color: Colors.grey[100],
                        ),

                        //ATTACHMENTS
                        Container(
                          padding: const EdgeInsets.all(large_padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.comment,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                  ),

                                  Text('Post Comment > ',
                                      style: GoogleFonts.poppins().copyWith(
                                          fontSize: SUB_TITLE,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),

                              Container(
                                margin: const EdgeInsets.all(normal_padding),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.post!.commentsCount,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    )
                  ),
                )
              ),
              AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 400),
                  height: controller.isLoading ? MediaQuery.of(context).size.height : 0,
                  child: controller.isLoading ? Center(
                    child: CircularProgressIndicator(),
                  ) : SizedBox()
              ),
            ]
          ),
        ),

        Positioned(
          left: 0,
          bottom: 0,
          child: Material(
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 2, top: 3),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.grey[200]!),
                ]
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.drag_handle,
                    color: Colors.grey,
                  ),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: small_padding),
                      child: Row(
                        children: <Widget>[
                          //LIKES ICONS
                          Container(
                            margin: const EdgeInsets.only(left: large_padding, right: large_padding),
                            child: Icon(Icons.favorite, size: 28, color: controller.isLiked ? Colors.red : Colors.grey,),
                          ),

                          //VERTICAL DIVIDER
                          Padding(
                            padding: const EdgeInsets.only(top: small_padding, bottom: small_padding),
                            child: VerticalDivider(
                              width: 5,
                              color: Colors.grey[200],
                              thickness: 2,
                            ),
                          ),

                          // COMMENT BAR
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: large_padding, right: large_padding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Comment ', style: GoogleFonts.poppins().copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,

                                        ),
                                        children: [
                                          TextSpan(
                                            text: '(${controller.post!.commentsCount})', style: GoogleFonts.poppins().copyWith(
                                              fontSize: SUB_TITLE,
                                            ),
                                          )
                                        ]
                                      ),
                                    ),
                                  ),

                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent[100],
                                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                                    ),
                                    child: Icon(Icons.add, color: Colors.green[400], size: 20),
                                  ).onTap(() {
                                    //ENTER ADD COMMENT SCREEN
                                  }),
                                ],
                              ),
                            ),
                          )

                        ]
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        )
      ],
    );
  }
}
