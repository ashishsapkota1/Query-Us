import 'package:flutter/material.dart';
import 'package:query_us/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF0A1045)),
        centerTitle: true,
        title: const Text('Query-Us',style: TextStyle(color: Color(0xFF0A1045)),),
        backgroundColor: const Color(0xFFE5EDF1) ,
        actions: [
          // IconButton(onPressed: (){
          //   showSearch(context: context, delegate: CustomSearchDelegte());
          // }, icon: const Icon(Icons.search),)
        ],
      ),
      body: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  elevation: 12,
                  margin: const EdgeInsets.all(3),
                  shadowColor: Colors.blue[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: height*0.22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 80,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Computer Engineering',style: TextStyle(color: Colors.blue[200]),),
                              SizedBox(width: width*0.1,),
                              const Text('2023-03-01'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding:  EdgeInsets.only(left: 8.0),
                                child: CircleAvatar(),
                              ),
                             SizedBox(
                                width: width*0.09,
                              ),
                              const Expanded(
                                child: Text('What is the difference between normal queue and circular queue in DSA ajhdghj adhgjaf hadgjf ahdjhfag ?',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),overflow:
                                  TextOverflow.visible,
                                maxLines: 3,)
                                ,
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: const[
                                Icon(Icons.keyboard_arrow_up,size: 35,),
                                Text('22')
                              ],
                            ),
                            Row(
                              children: const[
                                Icon(Icons.remove_red_eye_outlined),
                                SizedBox(width: 6,),
                                Text('99')
                              ],
                            ),
                            Row(
                              children: const[
                                Icon(Icons.message),
                                SizedBox(width: 6,),
                                Text('12 answers')
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

