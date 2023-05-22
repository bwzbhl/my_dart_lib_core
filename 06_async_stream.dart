//https://dart.cn/guides/libraries/library-tour#stream
import 'dart:async';

Future<void> main(List<String> args) async {
  receiving_test();
  err_test();
  await stream_test();

  print('done.');
}

//https://dart.cn/tutorials/language/streams#receiving-stream-events
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (final value in stream) {
    sum += value;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
  }
}

void receiving_test() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}

//https://dart.cn/tutorials/language/streams#error-events
Future<int> sumStream_1(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (final value in stream) {
      sum += value;
    }
  } catch (e) {
    return -1;
  }
  return sum;
}

Stream<int> countStream_1(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      throw Exception('Intentional exception');
    } else {
      yield i;
    }
  }
}

void err_test() async {
  var stream = countStream_1(10);
  var sum = await sumStream_1(stream);
  print(sum); // -1
}

//https://dart.cn/tutorials/language/streams#working-with-streams

//https://dart.cn/tutorials/language/streams#process-stream-methods

//https://dart.cn/tutorials/language/streams#modify-stream-methods

//https://dart.cn/tutorials/language/streams#transform-function

//https://dart.cn/tutorials/language/streams#reading-decoding-file

//https://dart.cn/tutorials/language/streams#listen-method

//https://dart.cn/articles/libraries/creating-streams#transforming-an-existing-stream

//https://dart.cn/articles/libraries/creating-streams#transforming-an-existing-stream

//一个周期性发送整数的函数例子
Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}

//将一个 Future 序列转换为 Stream 的函数
Stream<T> streamFromFutures<T>(Iterable<Future<T>> futures) async* {
  for (final future in futures) {
    var result = await future;
    yield result;
  }
}

Future<void> stream_test() async {
  const oneSecond = Duration(seconds: 1);

  StreamController<String> ctl = StreamController<String>();
  Stream stm = ctl.stream;

  stm.listen((event) {
    print('event from controller is: $event');
  });

  Future<void> addWithDelay(value) async {
    await Future.delayed(oneSecond);
    ctl.add(value);
  }

  addWithDelay('meat');
  addWithDelay('vegetable');
  addWithDelay('fruit');

  await Future.delayed(Duration(seconds: 4));
}

