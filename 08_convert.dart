//dart:convert - 编解码JSON，UTF-8等
//https://dart.cn/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more
import 'dart:convert';

void main() {
  decode_encode_JSON_sample();
  decoding_encoding_UTF_8_sample();
  print('done');
}

//编解码JSON https://dart.cn/guides/libraries/library-tour#decoding-and-encoding-json
void decode_encode_JSON_sample() {
  //使用 jsonDecode() 解码 JSON 编码的字符串为 Dart 对象：
  // NOTE: Be sure to use double quotes ("),
  // not single quotes ('), inside the JSON string.
  // This string is JSON, not Dart.
  var jsonString = '''
  [
    {"score": 40},
    {"score": 80}
  ]
''';

  var scores = jsonDecode(jsonString);
  assert(scores is List);

  var firstScore = scores[0];
  assert(firstScore is Map);
  assert(firstScore['score'] == 40);

  //使用 jsonEncode() 编码 Dart 对象为 JSON 格式的字符串:
  scores = [
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null}
  ];

  var jsonText = jsonEncode(scores);
  assert(jsonText ==
      '[{"score":40},{"score":80},'
          '{"score":100,"overtime":true,'
          '"special_guest":null}]');
}

//编解码UTF-8字符 https://dart.cn/guides/libraries/library-tour#decoding-and-encoding-utf-8-characters
void decoding_encoding_UTF_8_sample() {
  List<int> utf8Bytes = [
    0xc3, 0x8e, 0xc3, 0xb1, 0xc5, 0xa3, 0xc3, 0xa9,
    0x72, 0xc3, 0xb1, 0xc3, 0xa5, 0xc5, 0xa3, 0xc3,
    0xae, 0xc3, 0xb6, 0xc3, 0xb1, 0xc3, 0xa5, 0xc4,
    0xbc, 0xc3, 0xae, 0xc5, 0xbe, 0xc3, 0xa5, 0xc5,
    0xa3, 0xc3, 0xae, 0xe1, 0xbb, 0x9d, 0xc3, 0xb1
  ];

  var funnyWord = utf8.decode(utf8Bytes);

  assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');

  //将 UTF-8 字符串流转换为 Dart 字符串，为 Stream 的 transform() 方法上指定 utf8.decoder：
  /*
  var lines = utf8.decoder.bind(inputStream).transform(const LineSplitter());
try {
  await for (final line in lines) {
    print('Got ${line.length} characters from stream');
  }
  print('file is now closed');
} catch (e) {
  print(e);
}
*/

  //使用 utf8.encode() 将 Dart 字符串编码为一个 UTF8 编码的字节流
  List<int> encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

  assert(encoded.length == utf8Bytes.length);
  for (int i = 0; i < encoded.length; i++) {
    assert(encoded[i] == utf8Bytes[i]);
  }
}