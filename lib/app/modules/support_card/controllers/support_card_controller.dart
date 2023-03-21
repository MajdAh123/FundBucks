import 'package:app/app/data/models/models.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/support_card/providers/support_card_provider.dart';

class SupportCardController extends GetxController {
  final SupportCardProvider supportCardProvider;
  SupportCardController({
    required this.supportCardProvider,
  });

  var isLoading = false.obs;

  void setIsLoading(bool isLoading) => this.isLoading.value = isLoading;
  bool getIsLoading() => isLoading.value;

  var supportCardList = <SupportCardData>[].obs;
  var supportCardItemList = <SupportCardItem>[].obs;

  void setSupportCardList(supportCards) => supportCardList.value = supportCards;
  List<SupportCardData> getSupportCardList() => supportCardList;

  bool checkIfSupportCardListIsEmpty() => getSupportCardList().isEmpty;

  @override
  void onInit() {
    getSupportCards();
    super.onInit();
  }

  List<SupportCardItem> getSupportCardItemList() {
    return getSupportCardList()
        .map((e) => SupportCardItem(
              e.title ?? '',
              e.enTitle ?? '',
              e.content ?? '',
              e.enContent ?? '',
            ))
        .toList();
  }

  void getSupportCards() {
    setIsLoading(true);
    supportCardProvider.getSupportCards().then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        var supportCard = SupportCard.fromJson(value.body);
        print(supportCard);
        setSupportCardList(supportCard.data);
        supportCardItemList.value = getSupportCardItemList();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class SupportCardItem {
  SupportCardItem(this.title, this.enTitle, this.body, this.enBody,
      [this.isExpanded = false]);
  String title;
  String enTitle;
  String body;
  String enBody;
  bool isExpanded;
}
