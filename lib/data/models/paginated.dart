class Paginated<T extends dynamic> {
  final List<T> items;

  final int totalCount;

  const Paginated({
    required this.items,
    required this.totalCount,
  });
}

const int defaultLimitSize = 25;
const int firstPage = 1;
