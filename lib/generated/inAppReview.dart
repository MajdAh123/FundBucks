import 'package:in_app_review/in_app_review.dart';

class ReviewService {
  final InAppReview _inAppReview = InAppReview.instance;

  Future<void> requestReview() async {
    if (await _inAppReview.isAvailable()) {
      try {
        await _inAppReview.requestReview();
        // await _inAppReview.openStoreListing(appStoreId: "id6449863528");

        print("Review request sent");
      } catch (e) {
        print("Failed to request review: $e");
      }
    } else {
      print("In-app review is not available.");
      // Optionally redirect to the app store listing
      // await _inAppReview.openStoreListing(appStoreId: "id6449863528");
    }
  }
}
