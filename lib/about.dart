import 'package:flutter/material.dart';

class TeamMember {
  final String name;
  final String position;
  final String imageUrl;
  final String description;

  TeamMember({
    this.name = '',
    this.position = '',
    this.imageUrl = '',
    this.description = '',
  });
}

class AboutPage extends StatelessWidget {
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: "Abdul Kholiq Fajar",
      position: "21552011296",
      imageUrl:
          "assets/about/abdul1.jpg",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    TeamMember(
      name: "Azis Banon Sanjaya",
      position: "21552011453",
      imageUrl:
          "assets/about/azis.jpeg",
      description:
          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    TeamMember(
      name: "Gerry Pratama Putra",
      position: "21552011423",
      imageUrl:
          "assets/about/gerry.jpeg",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    // Add more team members as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'About Social Hub',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Team Developer - Social Hub',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  return _buildTeamMemberCard(teamMembers[index]);
                },
              ),
              SizedBox(height: 20),
              AppDescription(),
              SizedBox(height: 20),
              CopyrightSection(),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildTeamMemberCard(TeamMember teamMember) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(teamMember.imageUrl),
        ),
        title: Text(teamMember.name),
        subtitle: Text(teamMember.position),
        onTap: () {
          _showDialog(teamMember);
        },
      ),
    );
  }

  void _showDialog(TeamMember teamMember) {
    var context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(teamMember.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                teamMember.imageUrl,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10.0),
              Text(teamMember.position),
              SizedBox(height: 10.0),
              Text(teamMember.description),
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

class AppDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        // Tambahkan penjelasan aplikasi Anda di sini
        Text('Aplikasi ini adalah media sosial khusus wargi STT Bandung'),
      ],
    );
  }
}

class CopyrightSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Text('© 2023 Social Hub STTB'),
      ],
    );
  }
}