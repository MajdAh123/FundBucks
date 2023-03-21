import 'dart:convert';

import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/providers/contact_provider.dart';
import 'package:app/app/utils/laravel_echo/laravel_echo.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pusher_client/pusher_client.dart';

class ContactController extends GetxController
    with GetTickerProviderStateMixin {
  final ContactProvider contactProvider;
  ContactController({
    required this.contactProvider,
  });

  final descriptionTextEditingController = TextEditingController().obs;
  final titleTextEditingController = TextEditingController().obs;

  final homeController = Get.find<HomeController>();

  var counter = 0.obs;

  var openTicketsList = <Ticket>[].obs;
  var closedTicketsList = <Ticket>[].obs;

  void setCounter(value) => this.counter.value = value;
  int getCounter() => counter.value;

  String getDescription() => descriptionTextEditingController.value.text;
  String getDescriptionCounter() => '${getCounter().toString()}/250';

  final selectIndex = 0.obs;

  final colors = [
    mainColor,
    greyColor,
    secondaryColor,
  ];

  late AnimationController controller;
  late AnimationController operationController;
  late Animation<double> animation;

  final globalFormKey = GlobalKey<FormState>().obs;

  var isLoading = false.obs;

  var ticketNotifications = <int, int>{}.obs;

  getFormKey() => globalFormKey.value;

  void setIsLoading(bool value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setIndex(int index) => selectIndex.value = index;
  int getIndex() => selectIndex.value;
  Color getColor() => colors[selectIndex.value];

  @override
  void onInit() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    operationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(operationController);
    operationController.forward();
    controller.addListener(() {
      selectIndex.value = selectIndex.value == 0 ? 1 : 0;
      controller.forward();
      operationController.reverse(from: 0);
    });
    super.onInit();
    getAllTickets();
  }

  void getAllTickets() {
    getOpenTicket();
    getCloseTicket();
  }

  void onCreateButtonClick() {
    if (getFormKey().currentState.validate()) {
      createTicket();
    }
  }

  void createTicket() {
    setIsLoading(true);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final FormData _formData = FormData({
      'title': titleTextEditingController.value.text,
      'subject': descriptionTextEditingController.value.text,
    });
    contactProvider.createTicket(_formData).then((value) {
      setIsLoading(false);
      print(value.body);
      if (value.statusCode == 200) {
        titleTextEditingController.value.text = '';
        descriptionTextEditingController.value.text = '';
        getOpenTicket();
        // successfully_created_ticket
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: 'successfully_created_ticket'.tr,
          duration: Duration(seconds: defaultSnackbarDuration),
        ));
      }
    });
  }

  void getOpenTicket() {
    setIsLoading(true);
    contactProvider.getTickets(0).then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        var tickets = TicketList.fromJson(value.body);
        openTicketsList.value = tickets.data ?? [];
        if (openTicketsList.isNotEmpty) {
          setIndex(1);
          initTicketNotifications();
          listenToTickets();
        }
      }
    });
  }

  void listenToTickets() {
    for (var element in openTicketsList) {
      Channel channel = LaravelEcho.pusherClient
          .subscribe('private-ticket.${element.id!.toString()}');

      channel.bind("message.sent", (PusherEvent? event) {
        if (event?.data != null) {
          print(event!.data);
          _handleNewMessage(event.data);
        }
      });
    }
  }

  void _handleNewMessage(data) {
    final json = jsonDecode(data);
    final supportMessage = SupportMessage.fromJson(json);
    // supportMessages.add(supportMessage);
    // Functions.playMessagePopUpSound();
    updateTicketNotifications(supportMessage.ticketId, 1);
    setLatestMessageTicket(supportMessage.ticketId, supportMessage);
    // goToLastestMessage();
  }

  void setLatestMessageTicket(id, supportMessage) {
    var ticket = openTicketsList.firstWhere((element) => element.id == id);

    // Here check if the message is already in the list
    ticket.latestSupportMessage = supportMessage;
    openTicketsList.replaceRange(
      openTicketsList.indexOf(ticket),
      openTicketsList.indexOf(ticket) + 1,
      [ticket],
    );
  }

  void initTicketNotifications() {
    for (var element in openTicketsList) {
      if (ticketNotifications[element.id] != null) {
        continue;
      }
      ticketNotifications.addEntries({element.id!: 0}.entries);
    }
  }

  void updateTicketNotifications(ticketId, int? value) {
    if (ticketNotifications[ticketId] == null) {
      ticketNotifications[ticketId] = 1;
    }
    value == null
        ? ticketNotifications[ticketId] = (ticketNotifications[ticketId]! + 1)
        : ticketNotifications[ticketId] = value;
  }

  bool checkIfTicketNotifications(ticketId) {
    if (ticketNotifications[ticketId] != null) {
      if (ticketNotifications[ticketId]! > 0) {
        return true;
      }
    }
    return false;
  }

  void getCloseTicket() {
    setIsLoading(true);
    contactProvider.getTickets(1).then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        var tickets = TicketList.fromJson(value.body);
        closedTicketsList.value = tickets.data ?? [];
      }
    });
  }

  void clearAllForms() {
    titleTextEditingController.value.text = '';
    descriptionTextEditingController.value.text = '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
    operationController.dispose();
  }
}
