/* ERCİYES ÜNİVERSİTESİ 
   MÜHENDİSLİK FAKÜLTESİ
   BİLGİSAYAR MÜHENDİSLİĞİ BÖLÜMÜ
   MOBİL APPLİCATİON DEVELOPMENT DERSİ PROJE ÖDEVİ
   GRİDVİEW İLE FOTOĞRAF GALERİSİ YAPIMI
   DR. ÖĞRETİM ÜYESİ FEHİM KÖYLÜ
*/
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(PhotoGalleryApp());

class PhotoGalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView Fotoğraf Galerisi',
      debugShowCheckedModeBanner: false, // DEBUG yazısını kaldırır
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GalleryPage(),
    );
  }
}

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> randomImages = [];

  @override
  void initState() {
    super.initState();
    generateRandomImages();
  }

  void generateRandomImages() {
    final random = Random();
    randomImages = List.generate(
      12,
      (index) => 'https://picsum.photos/600/400?random=${random.nextInt(1000)}',
    );
  }

  void refreshImages() {
    setState(() {
      generateRandomImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Fotoğraf Galerisi'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 12.0), // Buton ile kenar arası boşluk
            child: IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Yenile',
              onPressed: refreshImages,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: randomImages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                randomImages[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.error, color: Colors.red)),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
