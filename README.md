## CustomPoll Package
This package provides a customizable and dynamic poll widget for Flutter applications. It allows you to create polls with various options, styles, and behaviors, making it easy to integrate polls into your app.

## Features
Customizable Poll Widget: Create polls with customizable titles, options, and styles.

Dynamic Voting: Users can vote and see real-time updates.

Reselection Option: Allow or disallow users to change their votes.

Timer Support: Display a countdown timer for the poll duration.

Private Polls: Create private polls that only specific users can vote on.

Stream Integration: Integrate with a stream to handle vote updates and send data to a server.

- CustomPoll


```dart
```

- CustomPoll.polls


```dart
```

- CustomPoll.radioBottomPolls


```dart
```

- CustomPoll.viewOnlyPollWidget


```dart
```

## Getting Started

To use this package, add custom_poll as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  custom_poll: ^1.0.0
```
Then, import the package in your Dart code:

```yaml
import 'package:custom_poll/custom_poll.dart';
```

- Usage
Here is a basic example of how to use the CustomPoll widget in your Flutter app:

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
      // Send vote data to the server
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
      body: CustomPoll(
        title: 'What is your favorite color?',
        options: ['Red', 'Blue', 'Green', 'Yellow'],
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(hours: 24)),
        onOptionSelected: (index) {
          print('Selected option: $index');
        },
        voteStream: voteStreamController,
        // Other parameters
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

## Example Parameters
- -title: The title of the poll.

- -options: A list of options for the poll.

- -startDate: The start date of the poll.

- -endDate: The end date of the poll.

- -onOptionSelected: A callback function that is called when an option is selected.

- -voteStream: A stream controller for handling vote updates.

## Additional Parameters

- -allowReselection: Whether users can reselect an option after voting.

- -showPercentages: Whether to display the percentage of votes for each option.

- -backgroundDecoration: The decoration applied to the background of the poll.

- -heightBetweenTitleAndOptions: The height between the title and the options.

- -votesText: The text displayed next to the vote count.

- -createdBy: The name of the user who created the poll.

- -userToVote: The name of the user who is allowed to vote.

- -private: Whether the poll is private.

- -loadingWidget: The widget to display while the poll is loading.

- -allStyle: The styles to apply to the poll.

- -maximumOptions: The maximum number of options allowed in the poll.

- -height: The height of the poll widget.

- -width: The width of the poll widget.

- -showTimer: Whether to show a timer for the poll duration.