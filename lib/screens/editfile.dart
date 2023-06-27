import 'package:codemydotcom/models/models.dart';
import 'package:codemydotcom/operation/methods.dart';
import 'package:flutter/material.dart';

class EditFile extends StatefulWidget {
  final String? selectedID;
  final String? fname;
  final String? lname;
  final String? avatar;
  const EditFile({
    Key? key,
    this.selectedID,
    this.fname,
    this.lname,
    this.avatar,
  }) : super(key: key);

  @override
  State<EditFile> createState() => _EditFileState();
}

class _EditFileState extends State<EditFile> {
  final fullname = TextEditingController();
  final lastname = TextEditingController();
  bool isEditing = true;

  @override
  void initState() {
    if (widget.selectedID == null) {
      setState(() {
        fullname.text = "";
        lastname.text = "";
        isEditing = false;
      });
    } else {
      fullname.text = widget.fname!;
      lastname.text = widget.lname!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: isEditing ? const Text('Edit User') : const Text('Create User'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 60, left: 10, right: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: isEditing
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.avatar!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                                child: Text(
                              'Avatar is Auto Generated',
                            )),
                          ),
                  ),
                  Form(
                    child: Column(children: [
                      TextFormField(
                        controller: fullname,
                        // keyboardType: TextInputType.name,
                      ),
                      TextFormField(
                        controller: lastname,
                        // keyboardType: TextInputType.name,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        User user = User(
                            firstname: fullname.text, lastname: lastname.text);
                        isEditing
                            ? await Methods()
                                .put('/users/${widget.selectedID}', user)
                            : await Methods().post('/users', user);
                      },
                      child: isEditing
                          ? const Text('Update')
                          : const Text('Create'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
