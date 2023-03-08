import 'package:app/data/client/models/default_response.dart';
import 'package:app/data/client/models/paginated_response.dart';
import 'package:retrofit/retrofit.dart';

typedef FutureApiResponse<T> = Future<HttpResponse<DefaultResponse<T>>>;
typedef ApiResponse<T> = HttpResponse<DefaultResponse<T>>;

typedef FuturePaginatedResponse<T>
    = Future<HttpResponse<DefaultResponse<PaginatedResponse<T>>>>;
