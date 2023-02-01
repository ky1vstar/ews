import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Credentials/ExchangeCredentials.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/TraceFlags.dart';
import 'package:ews/Http/BasicCredentials.dart';
import 'package:ews/ews.dart';

String primaryUserName = Platform.environment["USER_NAME"]!;
ExchangeCredentials primaryUserCredential = BasicCredentials(
  primaryUserName,
  Platform.environment["USER_PASSWORD"]!,
  null,
);

String secondaryUserName = Platform.environment["USER_NAME_SECONDARY"]!;
ExchangeCredentials secondaryUserCredential = BasicCredentials(
  secondaryUserName,
  Platform.environment["USER_PASSWORD_SECONDARY"]!,
  null,
);

ExchangeCredentials wrongUserCredential = BasicCredentials(
  "user",
  "password",
  null,
);

ExchangeService prepareExchangeService(ExchangeCredentials credentials,
    [requestedExchangeVersion = ExchangeVersion.Exchange2010_SP1]) {
  return ExchangeService.withVersion(requestedExchangeVersion)
    ..Url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx")
    ..Credentials = credentials
    ..TraceFlags = [TraceFlags.EwsRequest, TraceFlags.EwsResponse]
    ..TraceEnabled = true;
}

String randomString({int len = 8}) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

Future<void> exchangeBasicToOAuthCredentials() async {
  primaryUserCredential = await _exchangeCredentials(primaryUserCredential);
  secondaryUserCredential = await _exchangeCredentials(secondaryUserCredential);
}

/// https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth-ropc
Future<ExchangeCredentials> _exchangeCredentials(ExchangeCredentials credentials) async {
  if (credentials is! BasicCredentials) {
    return credentials;
  }

  final client = HttpClient();
  try {
    final requestParams = {
      "client_id": Platform.environment["CLIENT_ID"]!,
      "scope": "EWS.AccessAsUser.All",
      "username": credentials.userName,
      "password": credentials.password,
      "grant_type": "password",
    };
    final requestBytes = utf8.encode(Uri(queryParameters: requestParams).query);
    final request =
        await client.openUrl("post", Uri.parse("https://login.microsoftonline.com/organizations/oauth2/v2.0/token"));
    request.contentLength = requestBytes.length;
    request.add(utf8.encode(Uri(queryParameters: requestParams).query));
    final response = await request.close();
    final jsonResponse = await json.decoder.bind(response.transform(utf8.decoder)).first as Map<String, dynamic>;

    return OAuthCredentials(jsonResponse["access_token"] as String);
  } finally {
    client.close();
  }
}
