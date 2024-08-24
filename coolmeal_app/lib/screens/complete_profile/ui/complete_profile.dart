import 'package:coolmeal/core/widgets/plain_app_bar.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/about_you.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/about_you_more.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';

class ProceedToCompleteProfilePage extends StatelessWidget {
  final VoidCallback onGetStarted;

  const ProceedToCompleteProfilePage({Key? key, required this.onGetStarted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE6F0EE),
        appBar: PlainAppBar(
          title: '',
          onBackPressed: null,
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
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Complete Your Profile",
                  style: TextStyle(
                    color: Color(0xFF10212E),
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.00,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    //height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset(
                  'assets/images/proceed_to_complete.png',
                )),
                Expanded(
                  child: ListView(
                    children: [
                      DetailsInfoCard(
                        title: "About You",
                        description:
                            "Tell Us About Yourself to Personalize Your Meal Plans.",
                        image: Image.asset(
                          'assets/images/your_self.png',
                          height: 80,
                          width: 80,
                        ),
                      ),
                      DetailsInfoCard(
                          title: "How to connect with you",
                          description:
                              "Share Your Health & Fitness Details for Customized Plans.",
                          image: Image.asset(
                            'assets/images/health_and_fitness.png',
                            height: 80,
                            width: 80,
                          )),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: onGetStarted,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ],
            )));
  }
}

class DetailsInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final Image image;

  const DetailsInfoCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Card(
          elevation: 0,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  )),
                  Container(child: image)
                ],
              )),
        ));
  }
}

class ProfileCompletionScreen extends StatefulWidget {
  const ProfileCompletionScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompletionScreen> createState() =>
      _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _pages = [];

  void _gotoPage(int pageNo) => _pageController.animateToPage(pageNo,
      duration: const Duration(milliseconds: 450), curve: Curves.easeIn);

  @override
  void initState() {
    _pages = [
      ProceedToCompleteProfilePage(onGetStarted: () {
        _gotoPage(1);
      }),
      ProfileCompletionStepsWidget(onNext: () {
        Navigator.pushReplacementNamed(context, 'home');
      }, onBack: () {
        _gotoPage(0);
      })
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        });
  }
}

class ProfileCompletionStepsWidget extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const ProfileCompletionStepsWidget(
      {Key? key, required this.onBack, required this.onNext})
      : super(key: key);

  @override
  State<ProfileCompletionStepsWidget> createState() =>
      _ProfileCompletionStepsWidgetState();
}

class _ProfileCompletionStepsWidgetState
    extends State<ProfileCompletionStepsWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;

  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      AboutYou(
        onClickNext: () {
          _pageController.animateToPage(1,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn);
        },
      ),
      AboutYouMore(
        onClickNext: () {
          Navigator.pushReplacementNamed(context, Routes.homeScreen);
        },
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PlainAppBar(
          title: '',
          onBackPressed: () {
            if (_pageController.page == null) return;

            if (_pageController.page! == 0) {
              widget.onBack();
            }

            if (_pageController.page! > 0) {
              // Go back to previous step
              _pageController.animateToPage(
                _pageController.page!.toInt() - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
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
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: welcomeGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Row(
                  children: List.generate(_pages.length, (index) {
                    return Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 4,
                            decoration: ShapeDecoration(
                              color: _activePage >= index
                                  ? const Color(0xFF036D59)
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          )),
                    );
                  }),
                ),
                Expanded(
                    child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index % _pages.length];
                  },
                )),
              ]),
            )));
  }
}
