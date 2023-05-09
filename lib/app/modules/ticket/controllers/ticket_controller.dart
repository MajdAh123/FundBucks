import 'dart:convert';
import 'dart:io';

import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/ticket/providers/ticket_provider.dart';
import 'package:app/app/utils/laravel_echo/laravel_echo.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pusher_client/pusher_client.dart';

class TicketController extends GetxController {
  final TicketProvider ticketProvider;
  TicketController({
    required this.ticketProvider,
  });

  final contactController = Get.find<ContactController>();
  final homeController = Get.find<HomeController>();
  final messageTextFieldController = TextEditingController().obs;

  var filePath = ''.obs;
  var imageFile = File('').obs;
  final globalFormKey = GlobalKey<FormState>().obs;

  var status = 0.obs;

  void setStatus(value) => status.value = value;
  int getStatus() => status.value;

  final ImagePicker _picker = ImagePicker();

  String getFilePath() => filePath.value;

  void setFilePath(String path) => filePath.value = path;

  File getFile() => imageFile.value;

  setImageFilePath(File file) => imageFile.value = file;

  getFormKey() => globalFormKey.value;

  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);

  var supportMessages = <SupportMessage>[].obs;

  var isLoading = false.obs;
  var isSendingMessage = false.obs;

  void setIsLoading(value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setIsSendingMessage(value) => isSendingMessage.value = value;
  bool getIsSendingMessage() => isSendingMessage.value;

  final isTicketClosed = false.obs;
  List<String> simpleChoice = [];
  var ticketId = 0.obs;
  var ticketTitle = ''.obs;
  var ticketDesc = ''.obs;
  var ticketDate = ''.obs;
  var ticketUniqueId = ''.obs;

  void setTicketId(int id) => ticketId.value = id;
  int getTicketId() => ticketId.value;

  void setTicketTitle(String title) => ticketTitle.value = title;
  String getTicketTitle() => ticketTitle.value;

  void setTicketDesc(String desc) => ticketDesc.value = desc;
  String getTicketDesc() => ticketDesc.value;

  void setTicketDate(String date) => ticketDate.value = date;
  String getTicketDate() => ticketDate.value;

  void setTicketUniqueId(String uniqueId) => ticketUniqueId.value = uniqueId;
  String getTicketUniqueId() => ticketUniqueId.value;

  bool getIsTicketClosed() => isTicketClosed.value;
  void setIsClosed(bool value) => isTicketClosed.value = value;

  void setTicketData() {
    setTicketId(getFromArguments(0));
    setTicketUniqueId(getFromArguments(1));
    setTicketTitle(getFromArguments(2));
    setTicketDesc(getFromArguments(3));
    setTicketDate(getFromArguments(4));
    setIsClosed(getFromArguments(5));
    setStatus(getFromArguments(6));
  }

  dynamic getFromArguments(int index) {
    if (Get.arguments == null) {
      return '';
    }
    if (Get.arguments[index] == null) {
      return '';
    }
    return Get.arguments[index];
  }

  void getSupportMessages() {
    setIsLoading(true);
    ticketProvider.getTicket(getTicketId().toString()).then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        listenTicketChannel();
        var list = SupportMessageList.fromJson(value.body);
        supportMessages.value = list.data ?? [];
        goToLastestMessage();
      }
    });
  }

  void onSendMessageButtonClick() {
    if (getFormKey().currentState.validate()) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      sendMessage();
    }
  }

  void sendMessage() {
    setIsSendingMessage(true);
    final FormData _formData = FormData({
      'attachment': getFile().path.isEmpty
          ? null
          : MultipartFile(getFile(), filename: 'fundbucks.jpg'),
      'message': messageTextFieldController.value.text,
      'ticket_id': getTicketId(),
    });
    ticketProvider.createMessage(_formData).then((value) {
      print(value.body);
      setIsSendingMessage(false);
      if (value.statusCode == 200) {
        Functions.playSendButtonSound();
        clearFile();
        messageTextFieldController.value.text = '';
        final supportMessage = SupportMessage.fromJson(value.body['data']);
        supportMessages.add(supportMessage);
        setLatestMessageTicket(supportMessage.ticketId, supportMessage);
        goToLastestMessage();
        // Timer(Duration(seconds: 5), () {
        //   print('object');
        //   goToLastestMessage();
        // });
      }
    });
  }

  void clearFile() {
    setImageFilePath(File(''));
    setFilePath('');
  }

  void listenTicketChannel() {
    Channel channel = LaravelEcho.pusherClient
        .subscribe('private-ticket.${getTicketId().toString()}');

    channel.bind("message.sent", (PusherEvent? event) {
      if (event?.data != null) {
        print(event!.data);
        _handleNewMessage(event.data);
      }
    });

    final homeController = Get.find<HomeController>();
    if (homeController.initialized) {
      homeController.channel.bind("close.ticket", (PusherEvent? event) {
        if (event?.data != null) {
          print(event!.data);
          _handleCloseTicket();
        }
      });
    }
  }

  void _handleCloseTicket() {
    var ticket = contactController.openTicketsList
        .firstWhere((element) => element.id == getTicketId());
    ticket.status = 2;
    contactController.openTicketsList.replaceRange(
      contactController.openTicketsList.indexOf(ticket),
      contactController.openTicketsList.indexOf(ticket) + 1,
      [ticket],
    );
    setIsClosed(true);
    contactController.getAllTickets();
    Get.showSnackbar(GetSnackBar(
      title: 'success'.tr,
      message: 'successfully_closed_ticket'.tr,
      duration: const Duration(seconds: defaultSnackbarDuration),
    ));
  }

  void _handleNewMessage(data) {
    final json = jsonDecode(data);
    final supportMessage = SupportMessage.fromJson(json);
    if (supportMessages.contains(supportMessage)) {
      return;
    }
    supportMessages.add(supportMessage);
    Functions.playMessagePopUpSound();
    // contactController.getOpenTicket();
    contactController.updateTicketNotifications(getTicketId(), 1);
    setLatestMessageTicket(supportMessage.ticketId, supportMessage);
    goToLastestMessage();
  }

  void unsubscribeTicketChannel() {
    LaravelEcho.pusherClient.unsubscribe("message.sent");
    // LaravelEcho.instance.disconnect();
  }

  @override
  void onInit() {
    setTicketData();
    simpleChoice = getIsTicketClosed()
        ? ['details'.tr]
        : ['details'.tr, 'close_ticket'.tr];
    getSupportMessages();
    super.onInit();
    ever(isSendingMessage, (callback) {
      if (!callback) {
        goToLastestMessage();
      }
    });
    ever(supportMessages, (callback) {
      goToLastestMessage();
    });
  }

  void showImageSelection() {
    Get.bottomSheet(
      Container(
          // height: 100.h,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'from_gallery'.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: this.selectFromGallery,
              ),
              ListTile(
                title: Text(
                  'from_camera'.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: this.selectFromCamera,
              ),
            ],
          )),
      isDismissible: true,
      enableDrag: true,
    );
  }

  void selectFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setFilePath(image.path);
      setImageFilePath(File(getFilePath()));
    }
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  void selectFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setFilePath(image.path);
      setImageFilePath(File(getFilePath()));
    }
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  void closeTicket() {
    setIsLoading(true);
    setIsSendingMessage(true);
    ticketProvider.closeTicket(getTicketId()).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        // successfully_closed_ticket
        setIsLoading(false);
        setIsSendingMessage(false);
        setIsClosed(true);
        contactController.getAllTickets();
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'successfully_closed_ticket'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      }
    });
  }

  void showDetailsDialog() {
    // Get.close(1);
    Get.defaultDialog(
      title: "ticket_details".tr,
      backgroundColor: Colors.white,
      titleStyle: TextStyle(fontSize: 14.sp),
      titlePadding: EdgeInsets.symmetric(vertical: 10.h),
      radius: 10.r,
      middleText: 'awd',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'subject'.tr + ':',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                getTicketTitle(),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 4,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'description'.tr + ':',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  getTicketDesc(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 4,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'date'.tr + ':',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  getTicketDate(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ],
      ),
      cancel: GestureDetector(
        onTap: () {
          // Get.close(1);
          // Get.back(closeOverlays: true);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 36.w),
          child: TextButton(
            onPressed: () {
              Get.close(1);
            },
            style: TextButton.styleFrom(
              minimumSize: Size.fromHeight(13.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              // primary: mainColor,
              backgroundColor: mainColor,
            ),
            child: Text(
              'close'.tr,
              style: TextStyle(
                //fontFamily: FontFamily.inter,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
    contactController.updateTicketNotifications(getTicketId(), 0);
  }

  void goToLastestMessage() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (scrollController.hasClients) {
      print('going');
      scrollController.animateTo(supportMessages.length * 70.h,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }
  }

  void setLatestMessageTicket(id, supportMessage) {
    var ticket = contactController.openTicketsList
        .firstWhere((element) => element.id == id);
    ticket.latestSupportMessage = supportMessage;
    contactController.openTicketsList.replaceRange(
      contactController.openTicketsList.indexOf(ticket),
      contactController.openTicketsList.indexOf(ticket) + 1,
      [ticket],
    );
  }

  @override
  void onClose() {
    // unsubscribeTicketChannel();
    // try {
    //   LaravelEcho.instance.disconnect();
    // } catch (e) {}
  }
}
