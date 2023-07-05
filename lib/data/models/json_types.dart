typedef FromJsonT<T> = T Function(Object? json);
typedef ToJsonT<T> = Object? Function(T value);
typedef JsonMap = Map<String, dynamic>;