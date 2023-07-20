### Prepare Project
- Nama package/ folder project : 
    > baloonblooms

- Replace beberapa file di folder "baloonblooms" dengan hasil extract dari "BalloonBlooms.zip" (lib, assets, pubspec, plugins, ...)
- Buka terminal (powershell/ cmd)
- Eksekusi :
    > flutter pub get

- Buka file android/app/build.gradle
- Scroll ke bagian android {... defaultConfig ...}, edit "minSdkVersion flutter.minSdkVersion" menjadi :
    > minSdkVersion 19


### Prepare Application Icon
- Buka terminal (powershell/ cmd)
- Eksekusi :
    > flutter pub get

    > flutter pub run flutter_launcher_icons