import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../data_class.dart';

class UsersPhotos extends StatelessWidget {
  final dynamic userId;

  const UsersPhotos({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<DataClass>(context, listen: false).getUserData(userId);
    Provider.of<DataClass>(context, listen: false).getUsersPhotos(userId);
    final bool isLoading = Provider.of<DataClass>(context, listen: false).isLoading;

    final user = Provider.of<DataClass>(context, listen: false).user;
    final photoList = Provider.of<DataClass>(context, listen: false).photoList;
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text('${user!.username}\'s Photos'),
        backgroundColor: ColorConstants.greyColor,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: photoList!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14.0),
                    onTap: () => {},
                    child: Ink(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                child: Image.network(
                                  photoList[index].url,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              photoList[index].title,
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
