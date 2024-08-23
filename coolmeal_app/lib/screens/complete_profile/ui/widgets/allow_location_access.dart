import 'package:coolmeal/core/widgets/plain_app_bar.dart';
import 'package:flutter/material.dart';

class AllowAccessPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AllowAccessPage({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PlainAppBar(
          title: '',
          onBackPressed: () {
            onBack();
          },
          actions: [
            TextButton(
              onPressed: () {
                // UserInfomationRepository().increaseSkipCount().then((value) {
                //   navigatorKey.currentState?.pushReplacementNamed('/home');
                // });
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 170,
                    child: Image.asset(
                      'assets/location_access.png',
                    )),
                const SizedBox(height: 30),
                const Text(
                  "Allow Access to Your Location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 13),
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "by allowing location access, you can search for all places that near you and you can easly explore and to receive more accurate recommendation",
                      style: TextStyle(
                        color: Color(0xFF434560),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    // await determinePosition();
                    // navigatorKey.currentState?.pushReplacementNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'Share My Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    // navigatorKey.currentState?.pushReplacementNamed('/home');
                  },
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white),
                  child: Text(
                    'Not Now',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )));
  }
}
