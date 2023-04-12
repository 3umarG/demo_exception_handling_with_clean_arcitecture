import 'package:dartz/dartz.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/core/error_handling/failures.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/core/ui/enums/api_state.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/data/data_source/remote/remote_data_source.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/data/repository/remote_repository.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/domain/entities/post.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/domain/repository/base_repository.dart';
import 'package:flutter/cupertino.dart';

class PostsProvider extends ChangeNotifier {
  ApiState fetchPostsState = ApiState.initial;
  BaseRepository repository = RemoteRepositoryImp(RemoteDataSource());
  List<PostEntity> results = [];
  String errorMessage = "";

  Future<void> loadPosts() async {
    fetchPostsState = ApiState.loading;
    notifyListeners();

    Either<Failure, List<PostEntity>> result = await repository.fetchPosts();
    result.fold(
      (failure) {
        if(failure is ServerFailure){
          fetchPostsState = ApiState.errorServer;
        }else if(failure is NoConnectionFailure){
          fetchPostsState = ApiState.errorNoInternet;
        }else if(failure is DataParsingFailure){
          fetchPostsState = ApiState.errorParsingData;
        }
        errorMessage = failure.errorObject.message;
        notifyListeners();
      },
      (listOfPosts) {
        results = listOfPosts;
        fetchPostsState = ApiState.success;
        notifyListeners();
      },
    );
  }
}
