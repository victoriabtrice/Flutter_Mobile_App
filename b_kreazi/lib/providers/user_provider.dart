import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  TextEditingController nama = TextEditingController();
  TextEditingController noHp = TextEditingController();
  String gender = 'Laki-Laki';

  Map _userInfo = {};
  Map get userInfo => _userInfo;

  set changeGender(val) {
    gender = val;
    notifyListeners();
  }

  set saveUser(Map val) {
    _userInfo.addAll(val);
    nama.text = _userInfo['Nama'];
    noHp.text = _userInfo['No HP'];
    changeGender = _userInfo['Gender'];
    notifyListeners();
  }

  clearUser() {
    _userInfo = {};
    _img = null;
    _isImageLoaded = false;
    notifyListeners();
  }

  bool _edit = false;
  bool get edit => _edit;
  editState() {
    _edit = !_edit;
    notifyListeners();
  }


  //  cek ada gbr atau tdk
  bool _isImageLoaded = false;
  bool get isImageLoaded => _isImageLoaded;
  set isImageLoaded(val) {
    _isImageLoaded = val;
    notifyListeners();
  }

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _img;
  XFile? get img => _img;
  set img(val) {
    _img = val;
    notifyListeners();
  }

  pickedImage(bool isGallery) async {
    try {
      var res = await _imagePicker.pickImage(source: isGallery? ImageSource.gallery: ImageSource.camera);
      if (res != null) {
        img = res;
        isImageLoaded = true;
      }
    }
    catch (e) {
      isImageLoaded = false;
    }
  }
}