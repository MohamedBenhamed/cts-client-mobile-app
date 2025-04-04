class Result<T> {
  final T? data;
  final int customerId;
  final String? error;

  Result.success(this.data, this.customerId) : error = null;
  Result.failure(this.error, this.customerId) : data = null;

  bool get isSuccess => data != null;
}
