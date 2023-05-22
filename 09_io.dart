//dart:io - 服务器和命令行应用程序的 I/O
//https://dart.cn/guides/libraries/library-tour#dartio
import 'dart:io';
import 'dart:convert';

void main() {
  //Files and directories
  //https://dart.cn/guides/libraries/library-tour#files-and-directories

  read_flie_as_text();

  read_file_as_binary();

  handing_err();

  stream_file_content();

  write_content();

  list_file_in_directory();
  
  //httpserver();
  //httpcilent();

  print('done');
}

void read_flie_as_text() async {
  print('-------------Reading a file as text-----------');
  var config = File('config.txt');

  // Put the whole file in a single string.
  var stringContents = await config.readAsString();
  print('The file is ${stringContents.length} characters long.');

  // Put each line of the file into its own string.
  var lines = await config.readAsLines();
  print('The file is ${lines.length} lines long.');
}

void read_file_as_binary() async {
  print('----------reading a file as biinary-----------');
  var config = File('config.txt');

  var contents = await config.readAsBytes();
  print('The file is ${contents.length} bytes long.');
}

void handing_err() async {
   print('-------------handing error-----------');
  var config = File('config.txt');
  try {
    var contents = await config.readAsString();
    print(contents);
  } catch (e) {
    print(e);
  }
}

 void stream_file_content() async {
  print('');
  print('Stream file contents');
  var config = File('config.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = utf8.decoder.bind(inputStream).transform(const LineSplitter());
  try {
    await for (final line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }
 }
 

void write_content() async{
  print('===========write file contents=============');
  var logFile = File('log_file.txt');
  var sink = logFile.openWrite();
  sink.write('FILE ACCESSED ${DateTime.now()}\n');
  await sink.flush();
  await sink.close();

   sink = logFile.openWrite(mode: FileMode.append);
}

void list_file_in_directory() async {
   print('----------------list files in a directory--------------');
  var dir = Directory('tmp');

  try {
    var dirList = dir.list();
    await for (final FileSystemEntity f in dirList) {
      if (f is File) {
        print('Found file ${f.path}');
      } else if (f is Directory) {
        print('Found dir ${f.path}');
      }
    }
  } catch (e) {
    print(e.toString());
  }
}

//https://dart.cn/guides/libraries/library-tour#http-clients-and-servers
void httpserver() async {
  final requests = await HttpServer.bind('localhost', 8888);
  await for (final request in requests) {
    processRequest(request);
  }
}

void processRequest(HttpRequest request) {
  print('Got request for ${request.uri.path}');
  final response = request.response;
  if (request.uri.path == '/dart') {
    response
      ..headers.contentType = ContentType(
        'text',
        'plain',
      )
      ..write('Hello from the server');
  } else {
    response.statusCode = HttpStatus.notFound;
  }
  response.close();
}

void httpcilent() async {
  var url = Uri.parse('http://localhost:8888/dart');
  var httpClient = HttpClient();
  var request = await httpClient.getUrl(url);
  var response = await request.close();
  var data = await utf8.decoder.bind(response).toList();
  print('Response ${response.statusCode}: $data');
  httpClient.close();
}