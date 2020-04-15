import 'dart:convert';
import 'package:device_calendar/device_calendar.dart';

class HomePage {
  // String _data;
  DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();

  List<Calendar> _calendars;

  Future<void> fetchData() async {
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data) {
      permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
      if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
        //TODO
      }
    }

    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    print(calendarsResult?.data[0]);

    await Future.delayed(Duration(milliseconds: 600));
    // store dummy data
    _calendars = calendarsResult?.data;
  }
                                                     
  List<Calendar> get data => _calendars;
}