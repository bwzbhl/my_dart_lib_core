// https://dart.cn/guides/libraries/library-tour#uris
// 时间和日期 https://dart.cn/guides/libraries/library-tour#dates-and-times
void main() {
  URls_sample();
  date_and_time();
  print('done');
}

// URI(URLs), Uri 类 提供对字符串的编解码操作。这些函数用来处理 URI 特有的字符，例如 ＆ 和 = .
// Uri 类还可以解析和处理 URI—host，port，scheme等组件。
void URls_sample() {
  //编码和解码完整合法的URI:
  //使用 encodeFull() 和 decodeFull() 方法，对 URI 中除了特殊字符（例如 /， :， &， #）
  //以外的字符进行编解码，这些方法非常适合编解码完整合法的 URI，并保留 URI 中的特殊字符
  var uri = 'https://example.org/api?foo=some message';

  var encoded = Uri.encodeFull(uri);
  assert(encoded == 'https://example.org/api?foo=some%20message');

  var decoded = Uri.decodeFull(encoded);
  assert(uri == decoded);
  //上面的代码只编码了some和massage之间的空格

  // 编码和解码URI组件:
  // 使用 encodeComponent() 和 decodeComponent() 方法,
  // 对 URI 中具有特殊含义的所有字符串字符，特殊字符包括（但不限于）/， &，和 :
  uri = 'https://example.org/api?foo=some message';

  encoded = Uri.encodeComponent(uri);
  assert(
    encoded == 'https%3A%2F%2Fexample.org%2Fapi%3Ffoo%3Dsome%20message');
  
  decoded = Uri.decodeComponent(encoded);
  assert(uri == decoded);
  //上面的代码编码了所有的字符

  // 解析URI:
  // 使用 Uri 对象的字段（例如 path），来获取一个 Uri 对象或者 URI 字符串的一部分
  // 使用 parse() 静态方法，可以使用字符串创建 Uri 对象
  var uri1 = Uri.parse('https://example.org:8080/foo/bar#frag');

  assert(uri1.scheme == 'https');
  assert(uri1.host == 'example.org');
  assert(uri1.path == '/foo/bar');
  assert(uri1.fragment == 'frag');
  assert(uri1.origin == 'https://example.org:8080');

  //构建URI：
  //使用 Uri() 构造函数，可以将各组件部分构建成 URI 
  uri1 = Uri(
    scheme: 'https',
    host: 'example.org',
    path: '/foo/bar',
    fragment: 'frag',
    queryParameters: {'lang': 'dart'});
  assert(uri1.toString() == 'https://example.org/foo/bar?lang=dart#frag');

  // If you don’t need to specify a fragment, to create a URI with a http or https scheme, 
  // you can instead use the Uri.http or Uri.https factory constructors
  var httpUri = Uri.http('example.org', '/foo/bar', {'lang': 'dart'});
  var httpsUri = Uri.https('example.org', '/foo/bar', {'lang': 'dart'});

  assert(httpUri.toString() == 'http://example.org/foo/bar?lang=dart');
  assert(httpsUri.toString() == 'https://example.org/foo/bar?lang=dart');
}

// DateTime 对象代表某个时刻，时区可以是 UTC 或者本地时区
void date_and_time() {
  //DateTime对象可以通过若干构造函数和方法创建：
  // Get the current date and time.
  var now = DateTime.now();
  print('the current date and time: $now');
  
  // Create a new DateTime with the local time zone.
  var y2k = DateTime(2000); //January 1, 2000
  print('a new DateTime with the local time zone: $y2k'); 

  // Specify the date as a UTC time.(UTC 标准时间)
  y2k = DateTime.utc(2000); //1/1/2000, UTC
  print('UTC time: $y2k');

  // Specify a date and time in ms since the Unix epoch.
  y2k = DateTime.fromMillisecondsSinceEpoch(946684800000, isUtc: true);
  print('a date and time in ms since the Unix epoch: $y2k');

  // Parse an ISO 8601 date in the UTC time zone.
  y2k = DateTime.parse('2000-01-01T00:00:00Z');
  print('Parse an ISO 8601 date in the UTC time zone: $y2k');

  // Create a new DateTime from an existing one, adjusting just some properties:
  var sameTimeLastYear = now.copyWith(year: now.year - 1);
  print('Create a new DateTime from an existing one: $sameTimeLastYear');

  // 日期中 millisecondsSinceEpoch 属性返回自 “Unix 纪元（January 1, 1970, UTC）”以来的毫秒数:
  // 1/1/2000, UTC
  y2k = DateTime.utc(2000);
  assert(y2k.millisecondsSinceEpoch == 946684800000);

  // 1/1/1970, UTC
  var unixEpoch = DateTime.utc(1970);
  assert(unixEpoch.millisecondsSinceEpoch == 0);

  //Use the Duration class to calculate the difference between 
  //two dates and to shift a date forward or backward:
  y2k = DateTime.utc(2000);

  // Add one year.
  var y2001 = y2k.add(const Duration(days: 366));
  assert(y2001.year == 2001);

  // Subtract 30 days.
  var december2000 = y2001.subtract(const Duration(days: 30));
  assert(december2000.year == 2000);
  assert(december2000.month == 12);

  // Calculate the difference between two dates.
  // Returns a Duration object.
  var duration = y2001.difference(y2k);
  assert(duration.inDays == 366); // y2k was a leap year.
}