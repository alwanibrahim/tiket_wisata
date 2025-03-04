import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Pengembang',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.green[700]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.teal.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.teal[400]!, Colors.green[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.jpeg'),
              ),
            ),
            SizedBox(height: 20),

            // Name
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),

            // Role
            Text(
              'Pengembang Aplikasi Quranic',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 30),

            // Info Section
            _buildInfoCard(
              icon: Icons.email,
              title: 'Email',
              value: 'johndoe@example.com',
            ),
            SizedBox(height: 15),
            _buildInfoCard(
              icon: Icons.work,
              title: 'Spesialisasi',
              value: 'UI/UX Design & Backend Integration',
            ),
            SizedBox(height: 15),
            _buildInfoCard(
              icon: Icons.description,
              title: 'Tentang Saya',
              value:
                  'Saya adalah seorang pengembang aplikasi Flutter dengan fokus pada pembuatan aplikasi berbasis keagamaan, khususnya Al-Quran. Saya berkomitmen untuk menciptakan pengalaman pengguna yang bermakna dan mudah digunakan.',
            ),
            SizedBox(height: 20),

            // Quranic Quote
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.teal.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '"Dan barangsiapa yang bertakwa kepada Allah, niscaya Dia akan membukakan jalan keluar baginya."',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal[800],
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Amiri',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '(QS. At-Talaq: 2)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String value}) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: Colors.teal),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}