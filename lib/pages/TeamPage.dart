import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vsc/componenets/constants.dart';
import 'package:vsc/pages/WorkerStatisticsPage.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final future = Supabase.instance.client
      .from('users')
      .select('id, name, role, image_url');
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  PlatformFile? _selectedImage;

  Future<void> _deleteMember(String name, String role) async {
    try {
      final name = _nameController.text.trim();
      final role = _roleController.text.trim();
      await Supabase.instance.client
          .from('users')
          .delete()
          .match({'name': name, 'role': role});
      _nameController.clear();
      _roleController.clear();
      // Refresh the data table
      setState(() {
        future;
      });
    } catch (error) {
      print(error);
    }
  }

  // Delete the member with the given id
  Future<void> _addNewMember() async {
    try {
      // Get the new member data from the text fields
      final name = _nameController.text.trim();
      final role = _roleController.text.trim();

      // 1 - upload image(fileName)
      final imageUrl = await _uploadImage(_selectedImage!);

      // 3 - insert new user { name: name, role: role, imageUrl: url}
      await Supabase.instance.client
          .from('users')
          .insert({'name': name, 'role': role, 'image_url': imageUrl})
          .select('id')
          .single();

      // Clear the text fields and the selected image
      _nameController.clear();
      _roleController.clear();
      _selectedImage = null;

      // Refresh the data table
      setState(() {
        future.then((_) {});
      });
    } catch (error) {
      // Handle any errors that occur during the insert operation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding new member: $error'),
        ),
      );
    }
  }

  Future<String> _uploadImage(PlatformFile file) async {
    try {
      await Supabase.instance.client.storage
          .from('add_new')
          .upload(file.name, File(file.path!));
      return await Supabase.instance.client.storage
          .from('add_new')
          // Make sure to change 60 seconds for 3 months
          .createSignedUrl(file.name!, 58000000000000000);
    } catch (e) {
      // Handle any errors that occurred during the upload
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image: $e'),
        ),
      );
      return '';
    }
  }

  Future<void> _selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _selectedImage = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEnd2,
      appBar: AppBar(
        title: const Text('Team'),
        backgroundColor: gradientEnd2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter name',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _roleController,
                    decoration: const InputDecoration(
                        hintText: 'Enter role',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: _selectedImage?.name ?? 'Image',
                      hintStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        onPressed: _selectImage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _addNewMember,
                  child: const Text('Add New Member'),
                ),
                const SizedBox(width: 42), // Adjust the width for 2 cm spacing
                ElevatedButton(
                  onPressed: () {
                    String name = _nameController.text;
                    String role = _roleController.text;
                    _deleteMember(name, role);
                  },
                  child: const Text('Delete Member'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (snapshot.data == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final users = snapshot.data as List<dynamic>;
                    return SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 32),
                        height: 700,
                        width: 550,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Role',
                              style: TextStyle(color: Colors.black),
                            )),
                          ],
                          rows: users.map((item) {
                            return DataRow(
                              onSelectChanged: (bool? selected) {
                                if (selected ?? false) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkStat(
                                        id: item['id'],
                                        name: item['name'],
                                        role: item['role'],
                                        imageUrl: item['image_url'] ??
                                            'https://ui-avatars.com/api/?name=' +
                                                item["name"],
                                        workerName: '',
                                      ),
                                    ),
                                  );
                                }
                              },
                              selected: false,
                              cells: [
                                DataCell(
                                  Text(
                                    item['name'].toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                DataCell(Text(
                                  item['role'].toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
