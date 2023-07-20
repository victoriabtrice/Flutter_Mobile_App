import 'package:carousel_slider/carousel_slider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/custom_provider.dart';

class CarouselHome extends StatefulWidget {
  const CarouselHome({super.key});

  @override
  State<CarouselHome> createState() => _CarouselHomeState();
}

class _CarouselHomeState extends State<CarouselHome> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width*0.35,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 4,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 300),
        viewportFraction: 1.0,
      ),
      items: [
        for (int i = 1; i < 5 ; i++)
        // n Image of Slider
        GestureDetector(
          onTap: i==4? () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewInstagram())) : null,
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage('assets/BalloonBlooms$i.png'),
                fit: BoxFit.cover,
              )
            ),
          ),
        ),
      ],
    );
  }
}


class PortraitArtImgPicker extends StatefulWidget {
  const PortraitArtImgPicker({super.key});

  @override
  State<PortraitArtImgPicker> createState() => _PortraitArtImgPickerState();
}

class _PortraitArtImgPickerState extends State<PortraitArtImgPicker> {
  @override
  Widget build(BuildContext context) {
    final provCustom = Provider.of<CustomProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context, 
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
            ),
            builder: (BuildContext modalContext) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('Aksi lengkap menggunakan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            provCustom.pickedImage(true);
                            Navigator.pop(context);
                          }, 
                          tooltip: 'Gallery',
                          iconSize: 45,
                          icon: const Icon(Icons.image_rounded)
                        ),
                        IconButton(
                          onPressed: () {
                            provCustom.pickedImage(false);
                            Navigator.pop(context);
                          }, 
                          tooltip: 'Camera',
                          iconSize: 45,
                          icon: const Icon(Icons.camera_alt_rounded)
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          );
        },
        label: const Text('Choose Image'),
        icon: const Icon(Icons.upload_rounded),
      )
    );
  }
}

class WebViewInstagram extends StatelessWidget {
  const WebViewInstagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram - WebView'),
      ),
      body: const SafeArea(
        child: WebView(
          initialUrl: 'https://instagram.com/balloonblooms_medan', 
          javascriptMode: JavascriptMode.unrestricted,
        )
      ),
    );
  }
}