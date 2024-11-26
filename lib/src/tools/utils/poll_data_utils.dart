class PollDataUtils {
  static Map<int, double> calculatePercentages(int totalVotes, Map<int, int> votes, List<String> options) {
    Map<int, double> percentages = {};
    options.asMap().forEach((index, _) {
      double percentage = totalVotes > 0 ? ((votes[index] ?? 0) / totalVotes) * 100 : 0.0;
      percentages[index] = double.parse(percentage.toStringAsFixed(1));
    });
    return percentages;
  }
}
