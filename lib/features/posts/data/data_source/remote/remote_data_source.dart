import 'dart:convert';

import '../../../../../core/error_handling/exceptions.dart';
import '../../models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<PostModel>> fetchPosts() async {
    try {

      /// If http.get() throw exception that because no internet connection ..
      final response = await http.get(
        Uri.parse('jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        try {
          final List<PostModel> posts = [];
          final data = json.decode(utf8.decode(response.bodyBytes)) as List;

          for (int i = 0; i < data.length; i++) {
            posts.add(PostModel.fromJson(data[i]));
          }

          return posts;
        } on Exception {
          throw DataParsingException(
              statusCode: response.statusCode,
              message: "Can't Parse Data Correctly");
        }
      } else {
        throw ServerException(
            statusCode: response.statusCode,
            message: "Server or Source of Data has an Error !!");
      }
    } catch (e) {
      if ((e is ServerException) || (e is DataParsingException)) {
        rethrow;
      } else {
        throw NoConnectionException(
          statusCode: 0,
          message: "No Internet Connection , Please check your Connectivity !!",
        );
      }
    }
  }
}
