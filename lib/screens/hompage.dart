import 'package:codemydotcom/models/models.dart';
import 'package:codemydotcom/operation/methods.dart';
import 'package:codemydotcom/provider/data_class.dart';
import 'package:codemydotcom/screens/editfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var numw = Provider.of<DataClass>(context, listen: false);
    Future delay() async {
      await Future.delayed(
        const Duration(seconds: 3),
      );
    }

    getdata() async {
      delay();
      await Future.delayed(
        const Duration(seconds: 3),
      );
      debugPrint('Hello');
      numw.getpostdata();
    }

    Provider.of<DataClass>(context, listen: false).getpostdata();
    String selectedID;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Simple API"),
        ),
        body: Consumer<DataClass>(
          builder: (context, value, child) {
            // value.getpostdata();
            bool isloaded = value.isLoaded;
            List<User> lol = value.post ?? [];
            if (lol.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "Users",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        height: 500,
                        width: double.infinity * 0.3,
                        child: RefreshIndicator(
                          onRefresh: delay,
                          child: Visibility(
                            visible: isloaded,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: lol.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemCount: lol.length,
                                    itemBuilder: (context, i) {
                                      final String imagenetwork =
                                          lol[i].avatar ?? '';
                                      final String id = lol[i].id ?? '';
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                        ),
                                        margin: const EdgeInsets.all(5),
                                        child: ListTile(
                                          onTap: () {},
                                          leading: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: imagenetwork.isEmpty
                                                  ? const CircularProgressIndicator()
                                                  : Image.network(imagenetwork),
                                            ),
                                          ),
                                          title: Text(
                                              "${lol[i].firstname} ${lol[i].lastname}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          trailing: PopupMenuButton(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: ListTile(
                                                  enabled:
                                                      id.isEmpty ? false : true,
                                                  title: const Text('Edit'),
                                                  onTap: () {
                                                    selectedID = lol[i].id!;
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditFile(
                                                                selectedID:
                                                                    selectedID,
                                                                fname: lol[i]
                                                                    .firstname,
                                                                lname: lol[i]
                                                                    .lastname,
                                                                avatar: lol[i]
                                                                    .avatar,
                                                              )),
                                                    )
                                                        .then(
                                                      (value) {
                                                        getdata();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: ListTile(
                                                  enabled:
                                                      id.isEmpty ? false : true,
                                                  title: const Text('Delete'),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            'Are you sure you want to delete?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'No'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              var id =
                                                                  lol[i].id;
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Methods().del(
                                                                  '/users/$id');

                                                              getdata();
                                                            },
                                                            child: const Text(
                                                                'Yes'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          getdata();
                        },
                        child: const Text("Refresh"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (_) => const EditFile(),
              ),
            )
                .then(
              (value) {
                getdata();
              },
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
