import 'package:flutter/material.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/RFQModel.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class RFQFormScreen extends StatefulWidget {
  int id;
  RFQFormScreen({ Key? key, required this.id}) : super(key: key);

  @override
  State<RFQFormScreen> createState() => _RFQFormScreenState();
}

class _RFQFormScreenState extends State<RFQFormScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    TechnicianModel user = Provider.of<UserState>(context, listen: false).getUser;
    nameController.text = user.username;
    emailController.text = user.email;
    phoneNumberController.text = user.phoneNumber;
    addressController.text = Provider.of<UserState>(context, listen: false).ChosenAddress.address1.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TopRowBar(title: 'Request A Quote'),
              SizedBox(height: 20,),
              t13EditTextStyle('Name', nameController, isPassword: false),
              SizedBox(height: 20,),
              t13EditTextStyle('Email', emailController, isPassword: false),
              SizedBox(height: 20,),
              t13EditTextStyle('Phone Number', phoneNumberController, isPassword: false),
              SizedBox(height: 20,),
              t13EditTextStyle('Address', addressController, isPassword: false),
              SizedBox(height: 20,),
              t13EditTextStyle('Note', noteController, isPassword: false),
              SizedBox(height: 20,),
              T13Button(textContent: 'Request', onPressed: () async{
                await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request for quotes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to send a request?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                // Navigator.pop(context);
                String email = emailController.text;
                String name = nameController.text;
                String phone = phoneNumberController.text;
                String address = addressController.text;
                String note = noteController.text;
                RFQ RFQobj = RFQ(email: email, name: name, phone: phone, address: address, note: note);
                if(!email.isEmptyOrNull || !name.isEmptyOrNull || !phone.isEmptyOrNull || !address.isEmptyOrNull){
                  if(await CustomerService().requestAQuote(RFQobj, widget.id)){
                    toast("Request sent");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    toast("Error sending request");
                  }
                } else {
                  toast("Please check for empty fields");
                }
              }),
            
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
                toast("Request cancelled");
              },
            ),
          ],
        );
      },
      );
              }
          ),
            ]
      ),
    )));
      
  }
}