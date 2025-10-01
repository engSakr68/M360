enum ResType { model, list, type }

enum RequestMethod { get, post, put, patch, delete, download }

class HttpRequestModel {
  final String url;
  final Function(dynamic)? errorFunc;
  final ResType responseType;
  final RequestMethod requestMethod;
  final Map<String, dynamic>? requestBody;
  final Function(dynamic data)? responseKey;
  final Function(dynamic data)? toJsonFunc;
  bool? showLoader;
  bool refresh;

  final bool isFormData;

  HttpRequestModel(
      {required this.url,
      required this.responseType,
      required this.requestMethod,
      this.requestBody,
      this.responseKey,
      this.toJsonFunc,
      this.showLoader,
      this.errorFunc,
      this.isFormData = false,
      this.refresh = true});
}
