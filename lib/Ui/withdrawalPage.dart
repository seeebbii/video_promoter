import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalPage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal Request'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Text(
                      "Please select any on of the Withdrawal packages given below || (Only for Pakistani's) ||",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Please enter your EasyPaisa Number below and select any one of the Packages to Initiate a Withdrawal.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: 'Enter Your EasyPaisa Number Here'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: RaisedButton(
                    child: ListTile(
                      title: Text("Get 100rs in Exchange of 1000 Minutes"),
                      subtitle: Text("You Will be Paid Rs 100"),
                      trailing: Text("1000 minutes"),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () => {
                      Get.defaultDialog(
                        title: "Confirm Withdrawal",
                        middleText:
                            "Are you sure you want to Initiate a Withdrawal",
                        textCancel: "Cancel",
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent)
                            }
                          else
                            {
                              Navigator.pop(context),
                              Get.snackbar('Withdrawal Successful',
                                  'You will recieve your reward in Few minutes, Please Wait!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightGreen)
                            }
                        },
                        onCancel: () => {},
                      ),
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: RaisedButton(
                    child: ListTile(
                      title: Text("Get Rs.240 in Exchange of 2000 Minutes"),
                      subtitle: Text("You Will be Paid Rs Rs.240"),
                      trailing: Text("2000 minutes"),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () => {
                      Get.defaultDialog(
                        title: "Confirm Withdrawal",
                        middleText:
                            "Are you sure you want to Initiate a Withdrawal",
                        textCancel: "Cancel",
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent)
                            }
                          else
                            {
                              Navigator.pop(context),
                              Get.snackbar('Withdrawal Successful',
                                  'You will recieve your reward in Few minutes, Please Wait!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightGreen)
                            }
                        },
                        onCancel: () => {},
                      ),
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: RaisedButton(
                    child: ListTile(
                      title: Text("Get Rs.600 in Exchange of 4000 Minutes"),
                      subtitle: Text("You Will be Paid Rs 600"),
                      trailing: Text("4000 minutes"),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () => {
                      Get.defaultDialog(
                        title: "Confirm Withdrawal",
                        middleText:
                            "Are you sure you want to Initiate a Withdrawal",
                        textCancel: "Cancel",
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent)
                            }
                          else
                            {
                              Navigator.pop(context),
                              Get.snackbar('Withdrawal Successful',
                                  'You will recieve your reward in Few minutes, Please Wait!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightGreen)
                            }
                        },
                        onCancel: () => {},
                      ),
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: RaisedButton(
                    child: ListTile(
                      title: Text("Get Rs.12000 in Exchange of 1000 Hours"),
                      subtitle: Text("You Will be Paid Rs.12000"),
                      trailing: Text("1000 Hours"),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () => {
                      Get.defaultDialog(
                        title: "Confirm Withdrawal",
                        middleText:
                            "Are you sure you want to Initiate a Withdrawal",
                        textCancel: "Cancel",
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent)
                            }
                          else
                            {
                              Navigator.pop(context),
                              Get.snackbar('Withdrawal Successful',
                                  'You will recieve your reward in Few minutes, Please Wait!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightGreen)
                            }
                        },
                        onCancel: () => {},
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
