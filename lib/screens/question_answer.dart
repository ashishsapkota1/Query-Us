import 'package:flutter/material.dart';
import 'package:query_us/objects/get_question.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key, required this.answerData}) : super(key: key);

  final Question answerData;

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('answer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 12,
              margin: const EdgeInsets.all(3),
              shadowColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(minHeight: 0,minWidth: 0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/person.png'),
                          ),
                        ),
                       const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: Text(
                            widget.answerData.questionTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                            overflow: TextOverflow.visible,
                            maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(widget.answerData.description, style:const TextStyle(fontSize: 18),
                          overflow: TextOverflow.visible,
                          maxLines: 20,),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200],
                                  boxShadow: const [ BoxShadow(
                      color: Colors.black,
                      offset: Offset(2.0, 3.0),
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ), ]
                                ),
                                child: Text(widget.answerData.tags![0]!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ])),
            ),
            Card(
              elevation: 8,
              margin: const EdgeInsets.all(3),
              shadowColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 0,
                ),
                child: Column(
                  children: [
                    Text('answer hajfa ahkdf hdka ahdf fkaka fhdsjaakdkf fgjdfjk adgfajdhfdfgjgfjdgfjdgfjjfj',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.visible,
                    maxLines: 30,),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton( icon: (isLiked ? const Icon(Icons.thumb_up_off_alt): const Icon(Icons.thumb_up)),
                          onPressed: (){
                            setState(() {
                              isLiked = true;
                            });
                          },
                        ),

                      ],
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
