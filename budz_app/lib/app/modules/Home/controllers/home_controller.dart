import 'package:get/get.dart';

class HomeController extends GetxController {
  // Adicione os campos RxInt para controle das páginas
  final RxInt currentBannerPage = 0.obs;
  final RxInt currentTrailPage = 0.obs;

  // Adicione outras variáveis e métodos conforme necessário
  String petPhotoUrl = '';
  String petName = '';
  String petGender = '';
  String petBreed = '';

  void loadPetData(Map<String, dynamic> jsonData) {
    var petData = jsonData['pet'];
    petName = petData['name'];
    petGender = petData['gender'];
    petBreed = petData['breed'];
    petPhotoUrl = petData['photoUrl'];
  }
}
