import 'dart:async';

import 'package:custom_poll/custom_poll.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime startDate = DateTime(2024, 11, 25, 10, 0);
  DateTime endDate = DateTime(2024, 11, 30, 18, 0);

  // داده‌های نظرسنجی
  String title = "کدام زبان برنامه‌نویسی را بیشتر دوست دارید؟";
  List<String> options = ["دارت", "جاوا", "پایتون", "جاوا اسکریپت"];
  Map<int, int> votes = {
    0: 50, // دارت
    1: 30, // جاوا
    2: 70, // پایتون
    3: 40, // جاوا اسکریپت
  };
  int totalVotes = 190;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPoll(
                    title: 'کدام زبان برنامه‌نویسی محبوب‌تر است؟',
                    private: true,
                    allowReselection: false,
                    showPercentages: false,
                    showTimer: false,
                    options: const [
                      'فلاتر',
                      'جاوااسکریپت',
                      'پایتون',
                      'سی‌شارپ',
                    ],
                    votes: const {0: 10, 1: 20, 2: 15, 3: 5},
                    totalVotes: 50,
                    startDate: DateTime.now().add(const Duration(hours: 1)),
                    endDate: DateTime.now().add(const Duration(days: 1)),
                    maximumOptions: 20,
                    backgroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.grey.shade100,
                    ),
                    heightBetweenTitleAndOptions: 20,
                    votesText: 'رای‌ها',
                    createdBy: 'نام خلق کننده',
                    userToVote: 'نام کاربر',
                    loadingWidget: const CircularProgressIndicator(),
                    voteStream: StreamController<VoteData>(),
                    allStyle: Styles(
                      titleStyle: TitleStyle(
                        alignment: Alignment.center,
                        maxLines: 2,
                        minLines: 1,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      optionStyle: OptionStyle(
                        borderRadius: BorderRadius.circular(12),
                        selectedBorderColor: Colors.blue,
                        unselectedBorderColor: Colors.grey,
                        borderWidth: 2.0,
                        fillColor: Colors.white,
                        votedCheckmark: const Icon(Icons.check, color: Colors.green),
                        textSelectColor: Colors.blue,
                        otherTextPercentColor: Colors.black,
                        leadingVotedProgessColor: Colors.blue,
                        opacityLeadingVotedProgessColor: 0.5,
                        votedBackgroundColor: Colors.blue,
                        voteBorderProgressColor: Colors.blue,
                        progressBorderWidth: 1.0,
                      ),
                      votesTextStyle: VotesTextStyle(
                        alignment: Alignment.center,
                        paddingTop: 10,
                        paddingBottom: 10,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      dateStyle: DateStyle(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        textStart: 'شروع شده در: ',
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    onOptionSelected: (index) {
                      print('رای داده شد به گزینه $index');
                    },
                  ),
                  const SizedBox(height: 50),
                  CustomPoll(
                    private: true,
                    allowReselection: false,
                    showPercentages: false,
                    showTimer: false,
                    allStyle: Styles(
                      titleStyle: TitleStyle(textDirection: TextDirection.ltr, alignment: Alignment.centerLeft),
                      optionStyle: OptionStyle(
                        unselectedBorderColor: Colors.teal,
                        votedBackgroundColor: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        borderColor: Colors.purple,
                        leadingVotedProgessColor: Colors.purple,
                        height: 45,
                        voteBorderProgressColor: Colors.purple,
                        fillColor: Colors.white,
                      ),
                    ),
                    title: 'What is your favorite color?  ef ewf wewerwetwerwrweret  t t wtwetrw t  4twtrw4 ttttetertt   4tetree t ertert et ert e 543eter te t ert ter te4 t rret54e te tre te  ert 4 3tertert',
                    options: const ['Reddfdfd', 'Bluefdfdfd', 'Greendfdfdfd sd sad sadadsadadsadsa s adas wdwdawd aw', 'Yellowfdfdfd'],
                    votes: const {0: 5, 1: 10, 2: 3, 3: 7},
                    totalVotes: 25,
                    startDate: DateTime.now().add(const Duration(days: 1)),
                    endDate: DateTime.now().add(const Duration(minutes: 4)),
                    onOptionSelected: (int selectedOption) {
                      print('Selected option: $selectedOption');
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomPoll.viewOnlyPollWidget(
                      title: title,
                      options: options,
                      votes: votes,
                      totalVotes: totalVotes,
                      startDate: startDate,
                      endDate: endDate,
                      showPercentages: true,
                      votesText: "آرا",
                      heightBetweenTitleAndOptions: 12,
                      heightBetweenOptions: 16,
                      pollOptionsHeight: 50,
                      pollOptionsWidth: double.infinity,
                      pollOptionsBorderRadius: BorderRadius.circular(12),
                      pollOptionsFillColor: Colors.white,
                      pollOptionsSplashColor: Colors.grey[300]!,
                      votedProgressColor: Colors.blue,
                      leadingVotedProgessColor: Colors.blueAccent,
                      votedBackgroundColor: const Color(0xffEEF0EB),
                      votedPercentageTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      votesTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewOnlyPollWidget {}

/*class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final PageController _carouselController = PageController(viewportFraction: 0.2);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView.builder(
        controller: _carouselController,
        itemCount: 10,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // ایندکس فعال را به‌روزرسانی کنید
          });
        },
        itemBuilder: (context, index) {
          final isActive = index == _currentIndex; // بررسی فعال بودن آیتم
          return AnimatedBuilder(
            animation: _carouselController,
            builder: (context, child) {
              double value = 0.0;
              if (_carouselController.position.haveDimensions) {
                value = _carouselController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }
              return Transform.scale(
                scale: Curves.easeInOut.transform(value), // تغییر اندازه بر اساس انیمیشن
                child: child,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/300/${200 + (index * 10)}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final CarouselSliderController carouselController = CarouselSliderController();

    return CarouselSlider(
      carouselController: carouselController,
      items: images
          .map((i) => Builder(
                builder: (context) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    i,
                    fit: BoxFit.cover,
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 400, // Carousel slider height
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.2,
        aspectRatio: 2.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class CarouselExample extends StatefulWidget {
  const CarouselExample({super.key});

  @override
  _CarouselExampleState createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  final PageController _pageController = PageController(viewportFraction: 0.4, initialPage: 0);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200, // ارتفاع مناسب برای کروسل
        child: PageView.builder(
          controller: _pageController,
          itemCount: 4, // تعداد آیتم‌ها
          itemBuilder: (context, index) {
            double scale = (_currentPage - index).abs() <= 1 ? 1 - (_currentPage - index).abs() * 0.3 : 0.7;
            return Transform.scale(
              scale: scale,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: index.isEven ? Colors.blue : Colors.orange,
                ),
                child: ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network(images[index], fit: BoxFit.fitHeight)),
              ),
            );
          },
        ),
      ),
    );
  }
}

const List<String> images = [
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
  "https://i.pravatar.cc/300",
];

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  double _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 80; // ارتفاع معمولی تصاویر
    const double selectedItemHeight = 120; // ارتفاع تصویر انتخاب‌شده

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // ردیف بالایی تصاویر
            SizedBox(
              height: selectedItemHeight, // ارتفاع بخش تصاویر بالا
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    double scale = (_currentPage - index).abs() <= 1 ? 1 - (_currentPage - index).abs() * 0.3 : 0.7;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Transform.scale(
                        scale: scale,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: MediaQuery.of(context).size.width / 4 - 16,
                          height: selectedIndex == index ? selectedItemHeight : itemHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selectedIndex == index ? Colors.blue : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // ردیف پایینی تصاویر (PageView)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: 4,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/