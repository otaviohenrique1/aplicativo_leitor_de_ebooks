import 'package:aplicativo_leitor_de_ebooks/model/livro_model.dart';
import 'package:aplicativo_leitor_de_ebooks/pages/homepage.dart';
// import 'package:aplicativo_leitor_de_ebooks/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class Livro extends StatefulWidget {
  const Livro({
    super.key,
    required this.livro,
  });

  final LivroModel livro;

  @override
  State<Livro> createState() => _LivroState();
}

class _LivroState extends State<Livro> {
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";

  @override
  void initState() {
    download();
    super.initState();
  }

  download() async {
    if (Platform.isAndroid || Platform.isIOS) {
      String? firstPart;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      if (allInfo['version']["release"].toString().contains(".")) {
        int indexOfFirstDot = allInfo['version']["release"].indexOf(".");
        firstPart = allInfo['version']["release"].substring(0, indexOfFirstDot);
      } else {
        firstPart = allInfo['version']["release"];
      }
      int intValue = int.parse(firstPart!);
      if (intValue >= 13) {
        await startDownload();
      } else {
        if (await Permission.storage.isGranted) {
          await Permission.storage.request();
          await startDownload();
        } else {
          await startDownload();
        }
      }
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livro'),
      ),
      body: (loading)
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Downloading.... E-pub'),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Image.network(widget.livro.coverUrl),
                      ),
                      Text(
                        widget.livro.title,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          widget.livro.author,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // print("=====filePath======$filePath");
                          if (filePath == "") {
                            download();
                          } else {
                            VocsyEpub.setConfig(
                              themeColor: Theme.of(context).primaryColor,
                              identifier: "iosBook",
                              scrollDirection:
                                  EpubScrollDirection.ALLDIRECTIONS,
                              allowSharing: true,
                              enableTts: true,
                              nightMode: true,
                            );

                            // get current locator
                            VocsyEpub.locatorStream.listen((locator) {
                              // print('LOCATOR: $locator');
                            });

                            VocsyEpub.open(
                              filePath,
                              lastLocation: EpubLocator.fromJson({
                                "bookId": "${widget.livro.id}",
                                // "bookId": "2239",
                                "href": "/OEBPS/${widget.livro.title}.xhtml",
                                // "href": "/OEBPS/ch06.xhtml",
                                "created": 1539934158390,
                                "locations": {
                                  "cfi":
                                      "epubcfi(/0!/4/4[${widget.livro.title}]/2/2/6)"
                                  // "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                                }
                              }),
                            );
                          }
                        },
                        child: const Text('Abrir'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: const Text("Voltar ao inicio"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  startDownload() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/${widget.livro.title}.epub';
    // String path = '${appDocDir!.path}/sample.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        widget.livro.downloadUrl,
        // "https://vocsyinfotech.in/envato/cc/flutter_ebook/uploads/22566_The-Racketeer---John-Grisham.epub",
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
        });
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
  }
}
