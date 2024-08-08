import 'package:get/get.dart';

class HomeController extends GetxController {
  // Adicione os campos RxInt para controle das páginas
  final RxInt currentBannerPage = 0.obs;
  final RxInt currentTrailPage = 0.obs;

  // Adicione outras variáveis e métodos conforme necessário
  final RxString petPhotoUrl = ''.obs;
  final RxString petName = ''.obs;
  final RxString petGender = ''.obs;
  final RxString petBreed = ''.obs;

  void loadPetData(Map<String, dynamic> jsonData) {
    var petData = jsonData['pet'];
    petName.value = petData['name'];
    petGender.value = petData['gender'];
    petBreed.value = petData['breed'];
    petPhotoUrl.value = petData['photoUrl'];
  }
}
