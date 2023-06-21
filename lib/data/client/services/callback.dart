import 'package:app/data/client/models/default_response.dart';
import 'package:app/data/client/models/paginated_response.dart';
import 'package:retrofit/retrofit.dart';

export 'package:retrofit/retrofit.dart';
export 'package:app/data/client/models/paginated_response.dart';
export 'package:app/data/client/models/default_response.dart';

typedef FutureApiResponse<T> = Future<HttpResponse<DefaultResponse<T>>>;
typedef ApiResponse<T> = HttpResponse<DefaultResponse<T>>;

typedef FuturePaginatedResponse<T>
    = Future<HttpResponse<PaginatedResponse<T>>>;

typedef FromJsonT<T> = T Function(Object?);
