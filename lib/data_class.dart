import 'package:eclipse_test/models/photo.dart';
import 'package:eclipse_test/service/dio_service.dart';
import 'package:flutter/cupertino.dart';

import 'models/album.dart';
import 'models/comment.dart';
import 'models/post.dart';
import 'models/user.dart';

class DataClass with ChangeNotifier {
  User? user;
  Post? post;
  Album? album;
  List<User>? userList;
  List<Post>? postList;
  List<Photo>? photoList;
  List<Album>? albumList;
  List<Com>? commentList;
  DioService dioService = DioService();
  bool isLoading = true;

  Future getUserData(dynamic userId) async {
    user = await dioService.getUser(userId);
    notifyListeners();
  }

  Future getPostData(dynamic postId) async {
    post = await dioService.getPost(postId);
    notifyListeners();
  }

  Future getUserList(context) async {
    isLoading = true;

    userList = await dioService.getUsers(context);
    isLoading = false;

    notifyListeners();
  }

  Future getUsersPost(dynamic userId) async {
    postList = await dioService.getUserPosts(userId);

    notifyListeners();
  }

  Future getUsersPhotos(dynamic userId) async {
    photoList = await dioService.getUserPhotos(userId);

    notifyListeners();
  }

  Future getUsersAlbums(dynamic userId) async {
    isLoading = true;
    albumList = await dioService.getUserAlbums(userId);
    isLoading = false;
  }

  Future getPostsComments(dynamic postId) async {
    isLoading = true;
    commentList = await dioService.getPostsComments(postId);
    isLoading = false;
  }

  Future getAlbumsDetails(dynamic albumId) async {
    isLoading = true;
    album = await dioService.getAlbum(albumId);
    isLoading = false;
  }
}
