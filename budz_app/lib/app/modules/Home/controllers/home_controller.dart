import 'package:get/get.dart';

class HomeController extends GetxController {
  // Declare observable variables for pet data
  var petName = ''.obs;
  var petGender = ''.obs;
  var petBreed = ''.obs;
  var petPhotoUrl = ''.obs;

  // Simulate loading JSON data
  void loadPetData(Map<String, dynamic> jsonData) {
    var petData = jsonData['pet'];
    petName.value = petData['name'];
    petGender.value = petData['gender'];
    petBreed.value = petData['breed'];
    petPhotoUrl.value = petData['photoUrl'];
  }
}
