import 'package:flutter/material.dart';
import 'package:repair_pal/ChatsPage/MessageScreen/test.dart';
import 'package:repair_pal/constants.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: Drawer(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.notifications),
            )
          ],
        ),
        body: ChatList()

        /* ListView.builder(
        /* children:  [
          
         // ChatList(),
        ], */
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return NewWidget(
            chat: chatList[index],
          );
        },
      ), */
        );
  }
}

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            return NewWidget(
              chat: chatList[index],
            );
          },
        )
        /* NewWidget(
        chat: null,
      ), */
        );
  }
}

class NewWidget extends StatelessWidget {
  final Chat chat;

  const NewWidget({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 65,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset(
                      chat.thumbnail,
                      height: 65,
                      width: 65,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: const TextStyle(
                              fontSize: 18,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(chat.message,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ))
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          chat.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 24,
                          width: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            chat.counter,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


/* class MessagesStream extends StatefulWidget {
  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  final List<ChatMessageModel> _allMessagesContainedInTheStream = [];

  @override
  void initState() {
    _chatMessagesStream.listen((streamedMessages) {
      // _allMessagesContainedInTheStream.clear();

      debugPrint('Value from controller: $streamedMessages');

      _allMessagesContainedInTheStream.add(streamedMessages);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatMessageModel>(
      stream: _chatMessagesStream,
      builder: (context, snapshot) {
        return Expanded(
          child: ListView.builder(
            // reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: _allMessagesContainedInTheStream.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.hasData) {
                return UserChatBubble(
                  chatMessageModelRecord:
                      _allMessagesContainedInTheStream[index],
                );
              } else {
                print(snapshot.connectionState);
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}

class ChatMessageModel {
  final String? message;

  const ChatMessageModel({
    this.message,
  });

  factory ChatMessageModel.turnSnapshotIntoListRecord(Map data) {
    return ChatMessageModel(
      message: data['message'],
    );
  }

  List<Object> get props => [
        message!,
      ];
}

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen9';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();

  String? _userInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Chat Screen',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: kPrimaryColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      onChanged: (value) {
                        _userInput = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your answer here',
                        // border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _messageTextController.clear();

                      debugPrint(
                          'Adding a ChatMessageModel with the message $_userInput to the Stream');

                      ChatMessageModel chatMessageModelRecord =
                          ChatMessageModel(message: _userInput);

                      _chatMessagesStreamController.add(
                        chatMessageModelRecord,
                      );
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatefulWidget {
  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  final List<ChatMessageModel> _allMessagesContainedInTheStream = [];

  @override
  void initState() {
    _chatMessagesStream.listen((streamedMessages) {
      // _allMessagesContainedInTheStream.clear();

      debugPrint('Value from controller: $streamedMessages');

      _allMessagesContainedInTheStream.add(streamedMessages);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatMessageModel>(
      stream: _chatMessagesStream,
      builder: (context, snapshot) {
        return Expanded(
          child: ListView.builder(
            // reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: _allMessagesContainedInTheStream.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.hasData) {
                return UserChatBubble(
                  chatMessageModelRecord:
                      _allMessagesContainedInTheStream[index],
                );
              } else {
                print(snapshot.connectionState);
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}

class UserChatBubble extends StatelessWidget {
  final ChatMessageModel chatMessageModelRecord;

  const UserChatBubble({
    Key? key,
    required this.chatMessageModelRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 7 / 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
              color: kPrimaryColor,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            child: Text(
              "${chatMessageModelRecord.message}",
              style: TextStyle(
                fontSize: 17,
                // fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
} */