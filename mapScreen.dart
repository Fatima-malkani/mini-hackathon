import 'package:flutter/material.dart';
import 'package:project/Screens/addNewScreen.dart';
import 'package:project/Screens/showAlldonars.dart';
import 'package:project/Widgets/custom_color.dart';

const List<String> list = <String>['O+', 'B+', 'AB+', 'A+','A-','B-','AB-','O-'];

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appbarcolor().primaryColor,
        title: Text("Location"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/map.png"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  "Blood Groups",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: DropdownButton<String>(
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
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 50),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllDonorsScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 242, 79, 79),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text(
                      "Show All ",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewDonar()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 79, 79),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text(
                      "Add New Donar ",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
