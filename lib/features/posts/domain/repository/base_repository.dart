import 'package:dartz/dartz.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/core/error_handling/failures.dart';
import 'package:demo_exception_handling_with_clean_arcitecture/features/posts/domain/entities/post.dart';

abstract class BaseRepository {
  Future<Either<Failure, List<PostEntity>>> fetchPosts();
}