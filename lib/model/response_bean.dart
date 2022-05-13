

class BaseResponse<T> {

  T? data;
  int errorCode = 0;
  String errorMsg = '';

  BaseResponse(this.errorCode,this.errorMsg);

  BaseResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  bool isSuccess() => errorCode == 0;
}