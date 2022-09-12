import 'package:eclipse_test/const/colors.dart';
import 'package:eclipse_test/pages/album_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_class.dart';

class UsersAlbums extends StatefulWidget {
  final dynamic userId;

  const UsersAlbums({Key? key, required this.userId}) : super(key: key);

  @override
  State<UsersAlbums> createState() => _UsersAlbumsState();
}

class _UsersAlbumsState extends State<UsersAlbums> {
  @override
  void initState() {
    Provider.of<DataClass>(context, listen: false).getUserData(widget.userId);
    Provider.of<DataClass>(context, listen: false).getUsersAlbums(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final albumList = Provider.of<DataClass>(context).albumList;
    final user = Provider.of<DataClass>(context).user;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text('${user!.username}\'s Posts'),
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
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: albumList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14.0),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumDetail(albumId: albumList[index].id)))
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
                                    albumList[index].title,
                                    style: const TextStyle(
                                      fontSize: 20,
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
              ),
      ),
    );
  }
}
