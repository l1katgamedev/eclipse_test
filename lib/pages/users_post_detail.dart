import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../data_class.dart';

class UsersPostDetail extends StatefulWidget {
  final dynamic postId;
  final dynamic userId;

  const UsersPostDetail({Key? key, required this.postId, required this.userId}) : super(key: key);

  @override
  State<UsersPostDetail> createState() => _UsersPostDetailState();
}

class _UsersPostDetailState extends State<UsersPostDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  bool loaded = false;
  Dio dio = Dio();

  @override
  void initState() {
    Provider.of<DataClass>(context, listen: false).getUserData(widget.userId);
    Provider.of<DataClass>(context, listen: false).getPostData(widget.postId);
    Provider.of<DataClass>(context, listen: false).getPostsComments(widget.postId);
    _onWait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<DataClass>(context).post;
    final user = Provider.of<DataClass>(context).user;
    final commentList = Provider.of<DataClass>(context).commentList;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text('${user!.username}\'s ${widget.postId} Post'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Provider.of<DataClass>(context).isLoading == true
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Loading...',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            post!.title,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            post.body,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Comments:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: commentList!.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${commentList[index].id.toString()})",
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${commentList[index].name}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18, top: 0),
                                      child: Text(
                                        '${commentList[index].email}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(padding: const EdgeInsets.only(left: 16, top: 10), child: Text('${commentList[index].body}')),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 54),
                    child: TextButton(
                      onPressed: () => showModalBottomSheet(
                        context: (context),
                        builder: (builder) {
                          return Container(
                            height: 550,
                            color: Colors.transparent,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(14),
                                  topLeft: Radius.circular(14),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Name',
                                          hintText: 'Enter your name',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Email',
                                          hintText: 'Enter your email',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: commentController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Comment',
                                          hintText: 'Enter your comment',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          var record = {
                                            'userId': widget.postId,
                                            'id': widget.postId,
                                            'name': nameController.text,
                                            'email': emailController.text,
                                            'comment': commentController.text,
                                          };

                                          Response response;
                                          response = await dio.post('https://jsonplaceholder.typicode.com/posts/', data: record);
                                          Navigator.pop(context);
                                          print(response);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 2,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius: BorderRadius.circular(14),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Send',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            'Add comment',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
      ),
    );
  }

  _onWait() => Future.delayed(const Duration(milliseconds: 1000), () {
        loaded = true;
      });
}
