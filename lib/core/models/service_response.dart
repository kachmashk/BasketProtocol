class ServiceResponse<T> {
  final T? response;
  final String? errorMessage;

  ServiceResponse({this.response, this.errorMessage});
}
