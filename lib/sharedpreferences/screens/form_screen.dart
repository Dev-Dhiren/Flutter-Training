import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training/sharedpreferences/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final salaryController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Screen')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: lNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: salaryController,
                      decoration: InputDecoration(
                        labelText: 'Salary',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: onSave,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: onDetailBtnClicked,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Show Details'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    // print('Button Clicked..');

    String fName = fNameController.text.trim();
    String lName = lNameController.text.trim();
    String email = emailController.text.trim();
    double salary = double.tryParse(salaryController.text.trim()) ?? 0.0;
    int age = int.tryParse(ageController.text.trim()) ?? 0;

    // Save data to shared preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      await preferences.setString('FNAME', fName);
      await preferences.setString('LNAME', lName);
      await preferences.setString('EMAIL', email);
      await preferences.setDouble('SALARY', salary);
      await preferences.setInt('AGE', age);

      // await preferences.remove('EMAIL');
      // await preferences.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data saved successfully..')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error')));
    }
  }

  void onDetailBtnClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen()),
    );
  }
}
