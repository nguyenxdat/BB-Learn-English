import 'package:bb_earn_english/models/lyric.dart';

class LyricUtil {
  /// Format lyrics
  static List<Lyric> formatLyric(String lyricStr) {
    RegExp reg =
        RegExp(r"(?<=\[)\d{2}:\d{2}.\d{2,3}.*?(?=\[)|[^\[]+$", dotAll: true);

    var matches = reg.allMatches(lyricStr);
    var lyrics = matches.map((m) {
      var matchStr = m.group(0)!.replaceAll("\n", "");
      var symbolIndex = matchStr.indexOf("]");
      var time = matchStr.substring(0, symbolIndex);
      var lyric = matchStr.substring(symbolIndex + 1);
      var duration = lyricTimeToDuration(time);
      return Lyric(lyric, startTime: duration);
    }).toList();

    lyrics.removeWhere((lyric) => lyric.lyric.trim().isEmpty);
    for (int i = 0; i < lyrics.length - 1; i++) {
      lyrics[i].endTime = lyrics[i + 1].startTime;
    }
    lyrics.last.endTime = Duration(hours: 200);
    return lyrics;
  }

  static Duration lyricTimeToDuration(String time) {
    int hourSeparatorIndex = time.indexOf(":");
    int minuteSeparatorIndex = time.indexOf(".");
    return Duration(
      minutes: int.parse(
        time.substring(0, hourSeparatorIndex),
      ),
      seconds: int.parse(
          time.substring(hourSeparatorIndex + 1, minuteSeparatorIndex)),
      milliseconds: int.parse(time.substring(minuteSeparatorIndex + 1)),
    );
  }
}
