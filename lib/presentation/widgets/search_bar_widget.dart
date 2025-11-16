import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/state/provider/student_provider.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<StudentProvider>(context, listen: false);
    final provider = context.read<StudentProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search Students...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          provider.searchStudents(value);
        },
      ),
    );
  }
}
