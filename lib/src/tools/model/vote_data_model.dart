class VoteData {
  final int totalVotes;
  final Map<int, int> optionVotes;
  final Map<int, double> percentages;
  final int? selectedOption;

  VoteData({
    required this.totalVotes,
    required this.optionVotes,
    required this.percentages,
    this.selectedOption,
  });

  // تبدیل به JSON برای ارسال به سرور
  Map<String, dynamic> toJson() {
    return {
      'totalVotes': totalVotes,
      'optionVotes': optionVotes,
      'percentages': percentages.map((key, value) => MapEntry(key.toString(), value)),
      'selectedOption': selectedOption,
    };
  }
}
