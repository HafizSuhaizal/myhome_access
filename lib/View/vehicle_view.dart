import 'package:flutter/material.dart';
import '../Controller/vehicle_controller.dart';
import '../Model/vehicle_model.dart';

class AddVehicleView extends StatefulWidget {
  @override
  _AddVehicleViewState createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  double fem = 1.0; // Define your fem value
  double ffem = 1.0; // Define your ffem value

  final VehicleController _vehicleController = VehicleController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _plateNumberEditingController = TextEditingController();
  String ownerName = ''; // Owner name fetched based on user role
  String? _vehicleType; // Dropdown selected item

  @override
  void initState() {
    super.initState();
    _fetchOwnerName();
  }

  void _fetchOwnerName() async {
    // Logic to fetch owner name based on user role
    String roleName = 'owner'; // Replace with the actual role check logic
    if (roleName == 'owner') {
      ownerName = (await _vehicleController.fetchUserName()) ?? ''; // Update with your controller method
    }
  }

  void _handleAddVehicle() async {
    if (_formKey.currentState!.validate()) {
      String plateNumber = _plateNumberEditingController.text.trim();

      await _vehicleController.addOrUpdateVehicle(VehicleModel(
          ownerName: ownerName,
          plateNumber: plateNumber,
          vehicleType: _vehicleType ?? ''));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Vehicle Added')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Vehicle'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0 * fem, 40 * fem, 0 * fem, 0 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffececec),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 202 * fem, 36 * fem),
                  child: Text(
                    'Add Car',
                    style: TextStyle(
                      fontSize: 30 * ffem,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20 * fem),
                  width: 294 * fem,
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * fem),
                    border: Border.all(color: Color(0xaf001a39)),
                    color: Color(0xffffffff),
                  ),
                  child: TextFormField(
                    controller: _plateNumberEditingController,
                    decoration: InputDecoration(
                      labelText: 'Plate Number',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter plate number';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20 * fem),
                  width: 294 * fem,
                  height: 50 * fem,
                  padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * fem),
                    border: Border.all(color: Color(0xaf001a39)),
                    color: Color(0xffffffff),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _vehicleType,
                      isExpanded: true,
                      hint: Text('Select Vehicle Type'),
                      items: <String>['Car', 'Motorcycle'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _vehicleType = newValue;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20 * fem),
                  width: 71 * fem,
                  height: 26 * fem,
                  child: ElevatedButton(
                    onPressed: _handleAddVehicle,
                    child: Text(
                      'Add Car',
                      style: TextStyle(
                        fontSize: 17 * ffem,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff002d64),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
