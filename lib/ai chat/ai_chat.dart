
import 'package:digi_doctor/ai%20chat/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppManager/app_util.dart';
import '../Pages/Dashboard/OrganSymptom/speech.dart';
import '../Pages/voiceAssistantProvider.dart';

class AIChat extends StatefulWidget {
  const AIChat({Key? key}) : super(key: key);

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {

  @override
  void initState() {
    // TODO: implement initState
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage='chat';
    ChatProvider chat = Provider.of<ChatProvider>(context,listen: false);
    chat.students.clear();
    chat.students.add(Chat(message: 'You can ask questions here ,I am available 24/7.' ?? '', isAi: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider chat = Provider.of<ChatProvider>(context,listen: true);
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: true);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: ListView.builder(
                keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag,
                controller: chat.ctr,
                itemCount: chat.students.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                itemBuilder: (context, index){
                  return Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                    child: Align(
                      alignment: (chat.students[index].isAi==true?Alignment.topLeft:Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (index.isOdd?Colors.grey.shade200:Colors.indigo[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child:  Text(chat.students[index].message,style: const TextStyle(fontSize: 15),),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child:
                SizedBox(
                    height: 50,
                    child: AppBar(
                      backgroundColor:  Colors.indigo,
                      title: const Text('Chat bot'),
                    ))),

            Align(
              alignment: Alignment.bottomLeft,
              child: Visibility(
                visible: chat.students.length==1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: SizedBox(
                    height: 35,
                    child: ListView.builder(
                      itemCount:  chat.suggestions.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (  BuildContext context ,index){
                        return   Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: InkWell(
                            onTap: (){
                              chat.chatData(context,chat.suggestions[index]??'',false);
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.indigo,
                                      width: 2
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(chat.suggestions[index],style: const TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900),),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        listenVM.stopListening();
                        App().navigate(context,Speech(isFrom: 'chat',));
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.mic, color: Colors.white, size: 20, ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        controller: chat.chatTextC,
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    FloatingActionButton(
                      onPressed: (){
                        if(chat.chatTextC.value.text.toString()==''){

                        }else{
                          chat.chatData(context,chat.chatTextC.value.text.toString()??'',false);
                        }
                      },
                      backgroundColor: Colors.indigo,
                      elevation: 0,
                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
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