<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
 
 final voteStreamController = StreamController<VoteData>.broadcast();

  @override
  void initState() {
    super.initState();
   voteStreamController.stream.listen((voteData) {
    // ارسال به سرور
    _sendToServer(voteData);
  });
  }

  void _handleVoteChange() {
    final voteData = voteNotifier.value;
    _sendToServer(voteData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicPoll(
        onVoteChanged: voteStreamController,
        // سایر پارامترها
      ),
    );
  }

  @override
  void dispose() {
    voteStreamController.dispose();
    super.dispose();
  }

 Future<void> _sendToServer(VoteData voteData) async {
  try {
    final response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(voteData.toJson()),
    );

    if (response.statusCode == 200) {
      print('Vote data sent successfully');
    } else {
      print('Failed to send vote data');
    }
  } catch (e) {
    print('Error sending vote data: $e');
  }
}

}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
