import 'package:eclipse_test/const/colors.dart';
import 'package:eclipse_test/pages/album_detail.dart';
import 'package:eclipse_test/pages/users_albums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_class.dart';
import 'users_post_detail.dart';
import 'users_posts.dart';

class DetailPage extends StatefulWidget {
  final dynamic userId;

  const DetailPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    Provider.of<DataClass>(context, listen: false).getUserData(widget.userId);
    Provider.of<DataClass>(context, listen: false).getUsersPost(widget.userId);
    Provider.of<DataClass>(context, listen: false).getUsersPhotos(widget.userId);
    Provider.of<DataClass>(context, listen: false).getUsersAlbums(widget.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DataClass>(context).user;
    final postList = Provider.of<DataClass>(context).postList;
    final photoList = Provider.of<DataClass>(context).photoList;
    final albumList = Provider.of<DataClass>(context).albumList;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text(
          user?.username ?? 'qwe',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 3,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${user!.name}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Email: ${user.email}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Phone: ${user.phone}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Website: ${user.website}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Company: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.company!.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          user.company!.bs,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          user.company!.catchPhrase,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Address: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${user.address!.street}, ${user.address!.suite}, ${user.address!.city}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          user.address!.zipcode,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'Lat: ${user.address!.geo!.lat}, Lng: ${user.address!.geo!.lng}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${user.name}\'s Posts',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UsersPosts(
                                      userId: widget.userId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.teal,
                                  ),
                                  child: const Text(
                                    'View All',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14.0),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UsersPostDetail(
                                        postId: postList[index].id,
                                        userId: widget.userId,
                                      ),
                                    ),
                                  ),
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            postList![index].title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            postList[index].body,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             '${user.name}\'s Photos',
                  //             style: const TextStyle(
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.w700,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) => UsersPhotos(
                  //                     userId: userId,
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //             child: Container(
                  //                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(14),
                  //                   color: Colors.teal,
                  //                 ),
                  //                 child: const Text(
                  //                   'View All',
                  //                   style: TextStyle(color: Colors.white, fontSize: 16),
                  //                 )),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       SizedBox(
                  //         height: 250,
                  //         child: ListView.builder(
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           padding: EdgeInsets.zero,
                  //           physics: const AlwaysScrollableScrollPhysics(),
                  //           itemCount: 3,
                  //           itemBuilder: (context, index) {
                  //             return Container(
                  //               margin: const EdgeInsets.only(right: 16),
                  //               child: Material(
                  //                 color: Colors.transparent,
                  //                 child: InkWell(
                  //                   borderRadius: BorderRadius.circular(14.0),
                  //                   onTap: () => {},
                  //                   child: Ink(
                  //                     width: MediaQuery.of(context).size.width / 1.3,
                  //                     height: 250,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.circular(14.0),
                  //                     ),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  //                       child: Column(
                  //                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                         children: [
                  //                           ClipRRect(
                  //                             borderRadius: BorderRadius.circular(8),
                  //                             child: Container(
                  //                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  //                               child: Image.network(
                  //                                 photoList![index].thumbnailUrl,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 10,
                  //                           ),
                  //                           Text(
                  //                             photoList[index].title,
                  //                             style: const TextStyle(
                  //                               fontSize: 16,
                  //                               fontWeight: FontWeight.w600,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${user.name}\'s Albums',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UsersAlbums(
                                      userId: widget.userId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.teal,
                                  ),
                                  child: const Text(
                                    'View All',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14.0),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AlbumDetail(albumId: albumList[index].id),
                                      ),
                                    ),
                                  },
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            albumList![index].title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
      ),
    );
  }
}
