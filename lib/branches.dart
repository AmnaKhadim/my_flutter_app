import 'package:flutter/material.dart';

class Branch {
  final String name;
  final String location;
  final List<String> services;
  final Map<String, String> timetable;

  Branch({
    required this.name,
    required this.location,
    required this.services,
    required this.timetable,
  });
}

class BranchesScreen extends StatelessWidget {
  final List<Branch> branches = [
    Branch(
      name: "Lahore",
      location: "📍 Near Liberty Market, Lahore",
      services: ["Dine In", "Delivery", "Pickup"],
      timetable: {
        "Monday - Thrusday": "11:00am - 11:00pm",
        "Friday": "2:00pm - 12:00am",
        "Saturday - Sunday": "11:00am - 11:00pm",
      },
    ),
    Branch(
      name: "Karachi",
      location: "📍 Clifton Block 5, Karachi",
      services: ["Dine In", "Delivery"],
      timetable: {
        "Monday - Thrusday": "12:00pm - 12:00am",
        "Friday": "3:00pm - 1:00am",
        "Saturday - Sunday": "12:00pm - 12:00am",
      },
    ),
    Branch(
      name: "Islamabad",
      location: "📍 F-7 Markaz, Islamabad",
      services: ["Dine In", "Delivery", "Pickup"],
      timetable: {
        "Monday - Friday": "10:00am - 11:00pm",
        "Saturday - Sunday": "11:00am - 12:00am",
      },
    ),
    Branch(
      name: "Sahiwal",
      location: "📍 High Street, Sahiwal",
      services: ["Dine In", "Delivery", "Pickup"],
      timetable: {
        "Monday - Sunday": "11:00am - 11:00pm",
      },
    ),
    Branch(
      name: "Dolmen Mall",
      location: "📍 Dolmen Mall Clifton, Karachi",
      services: ["Dine In", "Delivery", "Pickup"],
      timetable: {
        "Mon - Thu": "11:00am - 10:00pm",
        "Fri": "2:00pm - 11:00pm",
        "Sat - Sun": "12:00pm - 12:00am",
      },
    ),
    Branch(
      name: "Emporium Mall",
      location: "📍 Johar Town, Lahore",
      services: ["Dine In", "Pickup"],
      timetable: {
        "Mon - Fri": "11:00am - 10:00pm",
        "Sat - Sun": "11:00am - 11:30pm",
      },
    ),
    Branch(
      name: "Mian Channu",
      location: "📍 GT Road, Mian Channu",
      services: ["Delivery", "Pickup"],
      timetable: {
        "Mon - Sun": "12:00pm - 11:00pm",
      },
    ),
    Branch(
      name: "Faisal Town",
      location: "📍 Faisal Town, Lahore",
      services: ["Dine In", "Delivery"],
      timetable: {
        "Mon - Thu": "11:30am - 11:00pm",
        "Fri": "2:00pm - 12:00am",
        "Sat - Sun": "12:00pm - 12:00am",
      },
    ),
    Branch(
      name: "G3 Lahore",
      location: "📍 G3 Block, Garden Town, Lahore",
      services: ["Dine In", "Pickup"],
      timetable: {
        "Mon - Sun": "11:00am - 11:00pm",
      },
    ),
    Branch(
      name: "Allama Iqbal Town",
      location: "📍 Allama Iqbal Town, Lahore",
      services: ["Dine In", "Delivery", "Pickup"],
      timetable: {
        "Mon - Thu": "11:00am - 11:00pm",
        "Fri": "2:00pm - 12:00am",
        "Sat - Sun": "11:00am - 11:30pm",
      },
    ),
  ];

  void _showBranchDetails(BuildContext context, Branch branch) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  branch.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // normal heading size
                  ),
                ),
                const SizedBox(height: 6),
                Text(branch.location,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14)), // normal subtitle
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Getting Directions...")),
                    );
                  },
                  icon: const Icon(Icons.directions, size: 20),
                  label: const Text("Get Directions",
                      style: TextStyle(fontSize: 14)),
                ),
                const Divider(thickness: 1, height: 24),
                const Text(
                  "Services Available",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                ...branch.services.map((service) => Row(
                  children: [
                    const Icon(Icons.check,
                        color: Colors.green, size: 18),
                    const SizedBox(width: 6),
                    Text(service, style: const TextStyle(fontSize: 14)),
                  ],
                )),
                const Divider(thickness: 1, height: 24),
                const Text(
                  "Timetable",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Column(
                  children: branch.timetable.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14)),
                          Text(entry.value,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Branches",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: branches.length,
        separatorBuilder: (context, index) =>
        const Divider(height: 1, thickness: 0.5),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.location_on,
                color: Colors.orange, size: 24),
            title: Text(branches[index].name,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16)),
            subtitle: Text(branches[index].location,
                style: const TextStyle(color: Colors.grey, fontSize: 13)),
            trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
            onTap: () => _showBranchDetails(context, branches[index]),
          );
        },
      ),
    );
  }
}
