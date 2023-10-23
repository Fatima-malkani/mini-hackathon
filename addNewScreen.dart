import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Widgets/custom_color.dart';
import 'package:project/Widgets/styling.dart';

const List<String> list = <String>[
  'O+',
  'B+',
  'AB+',
  'A+',
  'A-',
  'B-',
  'AB-',
  'O-'
];

class AddNewDonar extends StatefulWidget {
  const AddNewDonar({super.key});

  @override
  State<AddNewDonar> createState() => _AddNewDonarState();
}

class _AddNewDonarState extends State<AddNewDonar> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _lastdonationdate = TextEditingController();
  final donars = FirebaseFirestore.instance.collection('donars');
  DateTime selectedDate = DateTime.now();
  String dropdownValue = list.first;
  bool isEdit = false;
  String docId = '';
  String donarsDocId = DateTime.now().microsecondsSinceEpoch.toString();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, // Pass the context here
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _lastdonationdate.text =
            DateFormat('dd/MM/yyyy').format(selectedDate).toString();
      });
    }
  }

  Stream<QuerySnapshot> getTodos() {
    return donars.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor().primaryColor,
        title: const Text('New Donar Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Form(
              // key: //?????,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: TextFormFieldDecoration("Name"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: TextFormFieldDecoration("City"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: TextFormFieldDecoration("Phone number"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _lastdonationdate,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: TextFormFieldDecoration("Last Date "),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Blood Groups",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: TextStyle(color: appbarcolor().primaryColor),
                          underline: Container(
                            height: 2,
                            color: appbarcolor().primaryColor,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset('assets/images/small map.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 50),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 242, 79, 79),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: Text(
                                "Call ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await //addTodos();

                                  donars.doc(donarsDocId).set({
                                "title": _usernameController.text,
                                'address': _addressController.text,
                                "phoneNumber": _phoneNumberController.text,
                                'Date': _lastdonationdate.text,
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 242, 79, 79),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
