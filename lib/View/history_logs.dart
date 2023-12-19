import 'package:flutter/material.dart';
import '../Controller/history_logs.dart';
import '../Model/history_logs.dart';

class HistoryLogsView extends StatefulWidget {
  @override
  _HistoryLogsViewState createState() => _HistoryLogsViewState();
}

class _HistoryLogsViewState extends State<HistoryLogsView> {
  final HistoryLogsController _controller = HistoryLogsController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History Logs'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Emergency'),
              Tab(text: 'Visitor'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildHistoryLogsTab("emergency_alerts"),
            _buildHistoryLogsTab("visitor"),
          ],
        ),
      ),
    );
  }


  Widget _buildHistoryLogsTab(String collection) {
    return StreamBuilder<List<HistoryLogsItem>>(
      stream: collection == "emergency_alerts"
          ? _controller.getEmergencyLogsStream()
          : _controller.getVisitorLogsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var data = snapshot.data!;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            return ListTile(
            title: (collection == "emergency_alerts" || collection == "visitor")
            ? (collection == "emergency_alerts"
            ? Text(" ${item.type}")
                : Text(" ${item.plateNumber}"))
                : Text("Unknown Collection: ${collection}"),
            subtitle: (collection == "emergency_alerts")
            ? Text("Message: ${item.message}")
                : (collection == "visitor")
            ? Text("Status: ${item.status}")
                : null, // Set subtitle to null for other cases
            // Add more fields as needed

            // Add onTap to view details
            onTap: () {
            _showDetailsDialog(context, item, collection);
            },
            );
          },
        );
      },
    );
  }




  void _showDetailsDialog(BuildContext context, HistoryLogsItem item,
      String collection) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (collection == 'emergency_alerts') ...[
                Text('Type: ${item.type}'),
                Text('Message: ${item.message}'),
                Text('Timestamp: ${item.timestamp}'),
                // Display the image if available
                if (item.imageUrl != null) Image.network(item.imageUrl!),
              ],

              // Additional details for the 'Visitor' tab
              if (collection == 'visitor') ...[
                Text('Access Start Time: ${item.accessStartTime}'),
                Text('Access End Time: ${item.accessEndTime}'),
                Text('Plate Number: ${item.plateNumber}'),
                Text('Status: ${item.status}'),
                Text('Type of Access: ${item.typeOfAccess}'),
                Text('Vehicle Type: ${item.vehicleType}'),
                Text('Visitor Name: ${item.visitorName}'),
              ],
              // Add more details as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}