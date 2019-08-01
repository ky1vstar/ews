import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ews/Http/CookieContainer.dart' as http;
import 'package:ews/Http/EwsHttpWebResponse.dart';
import 'package:ews/Http/ICredentials.dart';
import 'package:ews/Http/IWebProxy.dart';
import 'package:ews/Http/WebCredentials.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebExceptionStatus.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Http/X509CertificateCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebRequest implements IEwsHttpWebRequest {
  @override
  String Accept;

  @override
  bool AllowAutoRedirect;

  @override
  X509CertificateCollection ClientCertificates;

  @override
  String ConnectionGroupName;

  @override
  String ContentType;

  @override
  http.CookieContainer CookieContainer;

  @override
  ICredentials Credentials;

  @override
  WebHeaderCollection Headers = WebHeaderCollection();

  @override
  bool KeepAlive;

  @override
  String Method;

  @override
  bool PreAuthenticate;

  @override
  IWebProxy Proxy;

  @override
  Uri RequestUri;

  @override
  int Timeout;

  @override
  bool UseDefaultCredentials;

  @override
  String UserAgent;

  @override
  void Abort() {
    // TODO: implement Abort
  }

  HttpClientRequest _request;

  @override
  Future<StreamConsumer<List<int>>> GetRequestStream() async {
    final user = (Credentials as WebCredentials).user;
    String password = (Credentials as WebCredentials).pwd;
    String auth = 'Basic ' + base64Encode(utf8.encode('$user:$password'));

    final client = HttpClient();
    _request = await client.postUrl(RequestUri);
    _request.headers.add("authorization", auth);
    return _request;
  }

  @override
  Future<IEwsHttpWebResponse> GetResponse() async {

    final HttpClientResponse response = await _request.close();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw new WebException(WebExceptionStatus.ProtocolError, response);
    }
    return EwsHttpWebResponse(this, response);
  }
}
