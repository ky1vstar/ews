import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  setUp(() async => exchangeBasicToOAuthCredentials());

  test('creates an appointment', () async {
    final service = prepareExchangeService(primaryUserCredential);

    final startTime = new DateTime(2019, 9, 9, 9, 10, 0);
    final appointment = new Appointment(service)
      ..Subject = "Dentist Appointment"
      ..Body = MessageBody.withText("The appointment is with Dr. Smith.")
      ..Start = startTime
      ..End = startTime.add(Duration(hours: 2));

    await appointment.SaveWithSendInvitationsMode(
        SendInvitationsMode.SendToNone);
    await appointment.Delete(DeleteMode.HardDelete);
  });
}
