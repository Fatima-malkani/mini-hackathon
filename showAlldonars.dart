import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Widgets/custom_color.dart';

class AllDonorsScreen extends StatefulWidget {
  AllDonorsScreen({super.key});

  @override
  State<AllDonorsScreen> createState() => _AllDonorsScreenState();
}

class _AllDonorsScreenState extends State<AllDonorsScreen> {
  CollectionReference donars = FirebaseFirestore.instance.collection('donars');
  String docId = '';


Future<void> deleteDocument(String docidd) async {
  try {
    await donars.doc(docidd).delete();
    print('Document deleted successfully.');
  } catch (e) {
    print('Error deleting document: $e');
  }
}


  Stream<QuerySnapshot> getTodos() {
    return donars.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Donors'),
        backgroundColor: appbarcolor().primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getTodos(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final docidd=snapshot.data!.docs[index].id;
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    width: 350,
                    height: 120,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffEB3738)),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data!.docs[index]['title']}",style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 8,),
                             Text(
                           "${snapshot.data!.docs[index]['address']}",),
                             SizedBox(height: 8,),

                          Text(
                            "${snapshot.data!.docs[index]['phoneNumber']}",
                            
                          ),
                            SizedBox(height: 8,),
                          Text(
                            "${snapshot.data!.docs[index]['Date']}",
                          ),
                          
                         
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: ()  {
                     deleteDocument(docidd);
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
