import 'package:dio/dio.dart';
import 'package:eclipse_test/models/album.dart';
import 'package:eclipse_test/models/photo.dart';

import '../models/comment.dart';
import '../models/post.dart';
import '../models/user.dart';

class DioService {
  final Dio dio = Dio();
  static const baseUrl = 'http://jsonplaceholder.typicode.com';
  static const usersEndpoint = '$baseUrl/users';
  static const postEndpoint = '$baseUrl/posts';
  static const albumEndpoint = '$baseUrl/albums';

  Future<List<User>> getUsers(context) async {
    try {
      Response response = await dio.get(usersEndpoint);

      if (response.statusCode == 200) {
        var getUsersData = response.data as List;
        var listUsers = getUsersData.map((e) => User.fromJson(e)).toList();
        return listUsers;
      } else {
        throw Exception('Failed to load users');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<User> getUser(dynamic userId) async {
    try {
      Response response = await dio.get('$usersEndpoint/$userId');

      return User.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<Post> getPost(postId) async {
    try {
      Response response = await dio.get('$postEndpoint/$postId');

      return Post.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception('Failed to load post: $e');
    }
  }

  Future<List<Post>> getUserPosts(id) async {
    try {
      Response response = await dio.get('$usersEndpoint/$id/posts');

      if (response.statusCode == 200) {
        var getUsersPostsData = response.data as List;
        var listPosts = getUsersPostsData.map((e) => Post.fromJson(e)).toList();
        return listPosts;
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<List<Photo>> getUserPhotos(id) async {
    try {
      Response response = await dio.get('$albumEndpoint/$id/photos');

      if (response.statusCode == 200) {
        var getUsersPhotosData = response.data as List;
        var listPhotos = getUsersPhotosData.map((e) => Photo.fromJson(e)).toList();
        return listPhotos;
      } else {
        throw Exception('Failed to load photos');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }

  Future<List<Album>> getUserAlbums(id) async {
    try {
      Response response = await dio.get('$usersEndpoint/$id/albums');

      if (response.statusCode == 200) {
        var getUsersAlbumsData = response.data as List;
        var listAlbums = getUsersAlbumsData.map((e) => Album.fromJson(e)).toList();
        return listAlbums;
      } else {
        throw Exception('Failed to load albums');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  Future<List<Com>> getPostsComments(id) async {
    try {
      Response response = await dio.get('$postEndpoint/$id/comments');

      if (response.statusCode == 200) {
        var getPostsCommentsData = response.data as List;
        var listComments = getPostsCommentsData.map((e) => Com.fromJson(e)).toList();
        return listComments;
      } else {
        throw Exception('Failed to load comments');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  Future<Album> getAlbum(albumId) async {
    try {
      Response response = await dio.get('$albumEndpoint/$albumId');

      return Album.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception('Failed to load album: $e');
    }
  }
}
