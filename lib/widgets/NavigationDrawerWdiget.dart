import 'package:flutter/material.dart';
import 'package:hazar_emlak/pages/add_real_estates.dart';
import 'package:hazar_emlak/pages/home_screen.dart';
import 'package:hazar_emlak/pages/putRealEstates.dart';
import 'package:hazar_emlak/pages/realEstatesDetail.dart';
import 'package:hazar_emlak/pages/real_estates_list.dart';
import 'package:hazar_emlak/pages/showUsers.dart';
import 'package:hazar_emlak/pages/show_detail.dart';
import 'package:hazar_emlak/pages/welcome.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green.shade300,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  buildMenuItem(
                    text: 'UserList',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Real Estate Ekle',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Real Estate Listesi',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'gayrimenkul detay',
                    icon: Icons.accessibility,
                    onClicked: () => selectedItem(context, 4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    VoidCallback? onClicked,
    required IconData icon,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.grey;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    //Navigator.of(context).pop();

    switch (index) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShowUsers(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddRealEstates(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RealEstatesList(),
        ));
        break;
      //TODO showDetails eklenecek
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        break;
    }
  }
}
