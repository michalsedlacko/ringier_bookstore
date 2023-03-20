class ApiListResponse<T> {
  T data;
  int total;
  int page;
  ApiListResponse({required this.data, this.total = 0, this.page = 1});
}
