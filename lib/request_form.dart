import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Requestform extends StatefulWidget {
  @override
  _RequestformState createState() => _RequestformState();
}

final Area = [
  "Chennai",
  "Thiruvallur",
  "Kancheepuram",
  "Puducherry",
  "Vellore"
];

class _RequestformState extends State<Requestform> {
  final _controllerName = TextEditingController();
  final _controllerNumber = TextEditingController();
  final _controllerArea = TextEditingController();
  final _controllerCategory = TextEditingController();
  final _controllerItem = TextEditingController();
  final _controllerDuration = TextEditingController();

  void _saveTask() async {
    if (_formkey.currentState!.validate()) {
      final taskName = _controllerName.text;
      final taskNumber = _controllerNumber.text;
      final taskArea = _controllerArea.text;
      final taskCategory = _controllerCategory.text;
      final taskItem = _controllerItem.text;
      final taskDuration = _controllerDuration.text;

      FirebaseFirestore.instance.collection("Datum").add({
        "Name": taskName,
        "PNumber": taskNumber,
        "Area": taskArea,
        "Category": taskCategory,
        "Item": taskItem,
        "Duration": taskDuration,
        "Server": FieldValue.serverTimestamp(),
        "ID": FieldValue.increment(1)
      });
      // _controllerName.clear();
      // _controllerNumber.clear();
      // _controllerCategory.clear();
      // _controllerItem.clear();
      // _controllerDuration.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Fields can't be empty"),
      ));
    }
  }

  String? _Name;
  String? _Phone_number;
  String? _Areaa;
  String? _value;
  String? _Category;
  String? _Item;
  String? _Duration;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controllerName,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrangeAccent)),
          // labelText: 'Name'),
          hintText: 'Name', hintStyle: TextStyle(color: Colors.white),
        ),
        validator: (String? Value) {
          if (Value!.isEmpty) {
            return 'Name is Required';
          }
        },
        onSaved: (String? Value) {
          _Name = Value!;
        },
      ),
    );
  }

  Widget _buildPhone_number() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _controllerNumber,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrangeAccent)),
        // labelText: 'Phone number'),
        hintText: 'Phone number', hintStyle: TextStyle(color: Colors.white),
      ),
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String? Value) {
        if (Value!.isEmpty) {
          return 'Phone number is Required';
        }
      },
      onSaved: (String? Value) {
        _Phone_number = Value!;
      },
    );
  }

  Widget _buildArea() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: DropdownButton<String>(
          value: _value,
          isExpanded: true,
          items: Area.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => this._value = value),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String Areas) => DropdownMenuItem(
        value: Areas,
        child: Text(
          Areas,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );

  Widget _buildcategory() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controllerCategory,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrangeAccent)),
          // labelText: 'what category does the item belongs to?'),
          hintText: 'what category does the item belongs to?',
          hintStyle: TextStyle(color: Colors.white),
        ),
        cursorColor: Colors.white,
        validator: (String? Value) {
          if (Value!.isEmpty) {
            return 'Category is Required';
          }
        },
        onSaved: (String? Value) {
          _Category = Value!;
        },
      ),
    );
  }

  Widget _buildItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controllerItem,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrangeAccent)),
          // labelText: 'Name of the Item'),
          hintText: 'Name of the Item',
          hintStyle: TextStyle(color: Colors.white),
        ),
        validator: (String? Value) {
          if (Value!.isEmpty) {
            return 'Item name is Required';
          }
        },
        onSaved: (String? Value) {
          _Item = Value!;
        },
      ),
    );
  }

  Widget _buildDuration() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controllerDuration,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrangeAccent)),
          // labelText: 'Lending time (Min/ Hours)'),
          hintText: 'Lending time (Min/ Hours)',
          hintStyle: TextStyle(color: Colors.white),
        ),
        keyboardType: TextInputType.number,
        validator: (String? Value) {
          if (Value!.isEmpty) {
            return 'Duration is Required';
          }
        },
        onSaved: (String? Value) {
          _Duration = Value!;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xDD000000),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Request Form"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildName(),
                    _buildPhone_number(),
                    _buildcategory(),
                    _buildItem(),
                    _buildDuration(),
                    _buildArea(),
                    SizedBox(
                      height: 70,
                    ),
                    SizedBox(
                      height: height * 0.08,
                      width: width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          _saveTask();
                          if (!_formkey.currentState!.validate()) {
                            return;
                          }

                          _formkey.currentState!.save();

                          // print(_Name);
                          // print(_Phone_number);
                          // print(_Category);
                          // print(_Item);
                          // print(_Duration);
                        },
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrangeAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60))),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
