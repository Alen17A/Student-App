import 'package:flutter/material.dart';
import 'package:student_app/presentation/widgets/student_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isList = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 214, 191),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Edumate",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          CircleAvatar(backgroundImage: AssetImage("assets/images/me_bw.jpg")),
        ],
        actionsPadding: EdgeInsets.all(10),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isList = !isList;
                  });
                },
                icon: isList ? Icon(Icons.view_list) : Icon(Icons.grid_view),
              ),
              SizedBox(height: 10),
              isList
                  ? Expanded(
                      child: ListView.separated(
                        itemCount: 15,
                        itemBuilder: (context, index) =>
                            StudentCard(index: index + 1, isList: isList),
                        separatorBuilder: (context, index) => Divider(
                          indent: 15,
                          endIndent: 15,
                          color: Colors.green,
                        ),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) =>
                            StudentCard(index: index+1, isList: isList),
                        itemCount: 15,
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20)
        ),
        child: IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 30,)),
      ),
    );
  }
}
