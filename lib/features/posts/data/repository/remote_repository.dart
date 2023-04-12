import 'package:dartz/dartz.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/core/error_handling/error_object.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/core/error_handling/exceptions.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/core/error_handling/failures.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/data/data_source/remote/remote_data_source.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/domain/entities/post.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/domain/repository/base_repository.dart';

class RemoteRepositoryImp extends BaseRepository {
  final BaseRemoteDataSource _dataSource;

  RemoteRepositoryImp(this._dataSource);

  @override
  Future<Either<Failure, List<PostEntity>>> fetchPosts() async {
    try {
      return Right(await _dataSource.fetchPosts());
    } on ServerException catch (e) {
      return Left(ServerFailure(
          ErrorObject(statusCode: e.statusCode, message: e.message)));
    } on DataParsingException catch (e) {
      return Left(DataParsingFailure(
          ErrorObject(statusCode: e.statusCode, message: e.message)));
    } on NoConnectionException catch (e) {
      return Left(NoConnectionFailure(
          ErrorObject(statusCode: e.statusCode, message: e.message)));
    }
  }
}
