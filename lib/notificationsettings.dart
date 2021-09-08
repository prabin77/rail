import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool toggleValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.green),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 260,
                  child: Text(
                    'App Notifications',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: toggleValue
                        ? Colors.greenAccent[100]
                        : Colors.redAccent[100].withOpacity(0.5),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeIn,
                        top: 3.0,
                        left: toggleValue ? 60.0 : 0.0,
                        right: toggleValue ? 0.0 : 60.0,
                        child: InkWell(
                          onTap: toggleButton,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 1000),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return RotationTransition(
                                  turns: animation, child: child);
                            },
                            child: toggleValue
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 35.0,
                                    key: UniqueKey(),
                                  )
                                : Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                    size: 35.0,
                                    key: UniqueKey(),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
              )
            ],
          ),
        ],
      ),
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
