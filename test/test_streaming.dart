import 'package:ews/Notifications/SubscriptionErrorEventArgs.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('streaming', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final subscription = await service.SubscribeToStreamingNotifications([
      FolderId.fromWellKnownFolder(WellKnownFolderName.Notes)
    ], [
      EventType.NewMail,
      EventType.Created,
      EventType.Deleted,
      EventType.Modified,
      EventType.Moved,
      EventType.Copied,
      EventType.FreeBusyChanged
    ]);
    StreamingSubscriptionConnection connection =
        new StreamingSubscriptionConnection(service, 30);
    connection.AddSubscription(subscription);
//    connection.OnNotificationEvent += OnNotificationEvent;
    connection.OnDisconnect.add(
        (Object sender, SubscriptionErrorEventArgs args) {
      print("OnDisconnect(${args.Exception})");
    });
    try {
      await connection.Open();
      await Future.delayed(const Duration(seconds: 5));
    } finally {
      // await connection.Close();
    }
  }, skip: true);
}
