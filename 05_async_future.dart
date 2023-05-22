// https://dart.cn/guides/libraries/library-tour#future
// 使用 Future 和 Stream 不需要导入 dart:async ，因为 dart:core 已经导出了这些类
void main() {
  future_sample();
  async_await_test();
  execution_within_async();
  async_await_handle_err();
  print('done it'); 
}

String createOrderMessage() {
  var order = fetchUserOrder();
  return 'Your order is: $order';
}

//https://dart.cn/codelabs/async-await#example-introducing-futures
//Example: synchronous functions
Future<String> fetchUserOrder() =>
    // Imagine that this function is more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );

Future<void> fetchUserOrder_2() {
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

void future_sample() {
  print(createOrderMessage());

  fetchUserOrder_2();
  print('Fetching user order...');
}

//https://dart.cn/codelabs/async-await#handling-errors
Future<void> printOrderMessage() async {
  try {
    print('Awaiting user order...');
    var order = await fetchUserOrder_throw_ex();
    print(order);
  } catch (err) {
    print('Caught error: $err');
  }
}

Future<String> fetchUserOrder_throw_ex() {
  // Imagine that this function is more complex.
  var str = Future.delayed(
      const Duration(seconds: 4),
      () => throw 'Cannot locate user order');
  return str;
}

void async_await_handle_err() async {
  await printOrderMessage();
}

//Example: synchronous functions
Future<String> fetchUserOrder_3() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );

Future<void> async_await_test() async {
  print('Fetching user order...');
  print(await createOrderMessage());
}

//https://dart.cn/codelabs/async-await#example-execution-within-async-functions
Future<void> printOrderMessage_() async {
  print('Awaiting user order...');
  var order = await fetchUserOrder_4();
  print('Your order is: $order');
}

Future<String> fetchUserOrder_4() {
  // Imagine that this function is more complex and slow.
  return Future.delayed(const Duration(seconds: 4), () => 'Large Latte');
}

void execution_within_async() async {
  countSeconds(4);
  await printOrderMessage_();
}

// You can ignore this function - it's here to visualize delay time in this example.
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}

//使用 Future 的 then() 方法在同一行执行了三个异步函数，要等待上一个执行完成，再执行下一个任务
/*
void runUsingfuture() {
  //...
  findEntryPoint().then((entryPoint) {
    return runExecutable(entryPoint, args);
  }).then(flushThenExit);
}

//通过 await 表达式实现等价的代码，看起来非常像同步代码
Future<void> runUsingAsyncAwait() async {
  //...
  var entryPoint = await findEntryPoint();
  var exitCode = await runExecutable(entryPoint, args);
  await flushThenExit(exitCode);
}

//async 函数能够捕获来自 Future 的异常
var entryPoint = await findEntryPoint();
try {
  var exitCode = await runExecutable(entryPoint, args);
  await flushThenExit(exitCode);
} catch (e) {
  // Handle the error...
}

//基本用法
//当 future 执行完成后，then() 中的代码会被执行。 then() 中的代码会在future 完成后被执行:
HttpRequest.getString(url).then((String result) {
  print(result);
}).catchError((e) {
  // Handle or ignore the error.
});
//then().catchError() 组合是 try-catch 的异步版本。

//链式异步编程
//then() 方法返回一个 Future 对象，这样就提供了一个非常好的方式让多个异步方法按顺序依次执行。
//如果用 then() 注册的回调返回一个 Future ，那么 then() 返回一个等价的 Future 。
//如果回调返回任何其他类型的值，那么 then() 会创建一个以该值完成的新 Future 。
//https://dart.cn/codelabs/async-await
Future result = costlyQuery(url);
result
    .then((value) => expensiveWork(value))
    .then((_) => lengthyComputation())
    .then((_) => print('Done!'))
    .catchError((exception) {
  /* Handle exception... */
});
//在上面的示例中，方法按下面顺序执行：
// 1.costlyQuery() 2.expensiveWork() 3.lengthyComputation()

//使用 await 编写的等效代码
try {
  final value = await costlyQuery(url);
  await expensiveWork(value);
  await lengthyComputation();
  print('Done!');
} catch (e) {
  /* Handle exception... */
}

//等待多个 Future
//有时代码逻辑需要调用多个异步函数，并等待它们全部完成后再继续执行。
//使用 Future.wait() 静态方法管理多个 Future 以及等待它们完成：
Future<void> deleteLotsOfFiles() async =>  ...
Future<void> copyLotsOfFiles() async =>  ...
Future<void> checksumLotsOfOtherFiles() async =>  ...

await Future.wait([
  deleteLotsOfFiles(),
  copyLotsOfFiles(),
  checksumLotsOfOtherFiles(),
]);
print('Done with all the long steps!');
*/