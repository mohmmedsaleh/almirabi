class ResponseResult {
  final bool status;
  final dynamic message;
  final dynamic data;

  ResponseResult({this.status = false, this.message, this.data});
}