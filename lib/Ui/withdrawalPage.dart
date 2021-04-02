import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_promoter/controllers/userController.dart';

class WithdrawalPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    int withdrawalAmount; int costToBeDeducted;
    final userController = Get.find<UserController>();

    void makeRequest() async {
      // READY FOR QUERY REQUEST
      String queryUrl = "https://www.videopromoter.tk/Video_app/withdrawalQuery.php?userId=${userController.user.id}&name=${userController.user.name}&email=${userController.user.email}&easyPaisa=${textEditingController.text}&package=${withdrawalAmount}";
      http.Response response = await http.get(queryUrl);
      print(response.body);

      // UPDATE USER BALANCE REQUEST
      String updateBal = 'https://www.videopromoter.tk/Video_app/updateBalance.php?id=${userController.user.id}&cost=${costToBeDeducted}';
      userController.user.balance = userController.user.balance - costToBeDeducted;
      userController.userBal -= costToBeDeducted;
      http.Response responseTwo = await http.get(updateBal);
      print(responseTwo.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal Request'),
        backgroundColor: Color.fromRGBO(255, 119, 129, 1),
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
                    keyboardType: TextInputType.number,
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
                        buttonColor: Color.fromRGBO(255, 119, 129, 1),
                        cancelTextColor: Color.fromRGBO(255, 119, 129, 1),
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          withdrawalAmount = 100,
                          costToBeDeducted = 1000,
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                            }
                          else
                            {
                              if(userController.user.balance >= 1000){
                                makeRequest(),
                                Navigator.pop(context),
                                Get.snackbar('Withdrawal Successful',
                                    'You will recieve your reward in Few minutes, Please Wait!',
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Color.fromRGBO(171, 63, 65, 1))
                              }else{
                                Get.snackbar('Insufficient Balance',
                                    'You are not eligible for this offer.',
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                              }
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
                        buttonColor: Color.fromRGBO(255, 119, 129, 1),
                        cancelTextColor: Color.fromRGBO(255, 119, 129, 1),
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          withdrawalAmount = 240,
                          costToBeDeducted = 2000,
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                            }
                          else
                            {

                              if(userController.user.balance >= 2000){
                                makeRequest(),
                                Navigator.pop(context),
                                Get.snackbar('Withdrawal Successful',
                                    'You will recieve your reward in Few minutes, Please Wait!',
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Color.fromRGBO(171, 63, 65, 1))
                              }else{
                                Get.snackbar('Insufficient Balance',
                                    'You are not eligible for this offer.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                              }


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
                        buttonColor: Color.fromRGBO(255, 119, 129, 1),
                        cancelTextColor: Color.fromRGBO(255, 119, 129, 1),
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          withdrawalAmount = 600,
                          costToBeDeducted = 4000,
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                            }
                          else
                            {
                              if(userController.user.balance >= 4000){
                                makeRequest(),
                                Navigator.pop(context),
                                Get.snackbar('Withdrawal Successful',
                                    'You will recieve your reward in Few minutes, Please Wait!',
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Color.fromRGBO(171, 63, 65, 1))
                              }else{
                                Get.snackbar('Insufficient Balance',
                                    'You are not eligible for this offer.',
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                              }
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
                        buttonColor: Color.fromRGBO(255, 119, 129, 1),
                        cancelTextColor: Color.fromRGBO(255, 119, 129, 1),
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        onConfirm: () => {
                          withdrawalAmount = 12000,
                          costToBeDeducted = 60000,
                          if (textEditingController.text.isBlank)
                            {
                              Navigator.pop(context),
                              Get.snackbar('Number Missing',
                                  'Please enter your EasyPaisa number before Initiating a Withdrawal',
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                            }
                          else
                            {
                              if(userController.user.balance >= 60000){
                                makeRequest(),
                                Navigator.pop(context),
                                Get.snackbar('Withdrawal Successful',
                                    'You will recieve your reward in Few minutes, Please Wait!',
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Color.fromRGBO(171, 63, 65, 1))
                              }else{
                                Get.snackbar('Insufficient Balance',
                                    'You are not eligible for this offer.',
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Color.fromRGBO(255, 119, 129, 1))
                              }
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
