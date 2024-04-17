// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({
    required this.onPressed, 
    required this.icon});
}

class PinterestMenu extends StatelessWidget {
  final bool show;

  PinterestMenu({
    super.key, 
    this.show = true});
  
  final List<PinterestButton> items = [
    PinterestButton(icon: Icons.home, onPressed: (){}),
    PinterestButton(icon: Icons.search, onPressed: (){}),
    PinterestButton(icon: Icons.notifications, onPressed: (){}),
    PinterestButton(icon: Icons.supervised_user_circle, onPressed:(){}),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (show) ? 1 : 0,
        child: _PinterestMenuBackground(
          child: _MenuItems(menuItems: items),
        ),
      ),
    ); 
   }
}

class _PinterestMenuBackground extends StatelessWidget {
  
  final Widget child;
  
  const _PinterestMenuBackground({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(        
      width: 250,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5
          )            
        ] 
      ),
      child: child,
    );
  }
}


class _MenuItems extends StatelessWidget {

  final List<PinterestButton> menuItems;
  const _MenuItems({
    required this.menuItems
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (i) => _PinterestMenuButton( index: i, item: menuItems[i])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  
  final int index;
  final PinterestButton item;
  
  const _PinterestMenuButton({
    required this.index, 
    required this.item
  });

  @override
  Widget build(BuildContext context) {

    final selectItem = Provider.of<_MenuModel>(context).selectedItem;


    return GestureDetector(
      onTap:(){
        Provider.of<_MenuModel>(context, listen: false).selectedItem = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: (selectItem == index )? 35 : 24,
          color: (selectItem == index) 
            ? Colors.green 
            : Colors.black,
        ),
      ),
    );
  }
}


class _MenuModel with ChangeNotifier {
  int _selectedItem = 0;

  int get selectedItem => _selectedItem;

  set selectedItem(int index) {
    _selectedItem = index;
    notifyListeners();
  }


}