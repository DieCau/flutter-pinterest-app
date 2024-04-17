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
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButton> items;


  const PinterestMenu({
    super.key, 
    this.show = true,
    this.backgroundColor = Colors.white,
    this.activeColor     = Colors.black,
    this.inactiveColor   = Colors.pink, 
    required this.items,
  });
  
  // final List<PinterestButton> items = [
  //   PinterestButton(icon: Icons.home, onPressed: (){}),
  //   PinterestButton(icon: Icons.search, onPressed: (){}),
  //   PinterestButton(icon: Icons.notifications, onPressed: (){}),
  //   PinterestButton(icon: Icons.supervised_user_circle, onPressed:(){}),
  // ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (show) ? 1 : 0,
        child: Builder(
          builder: (context){ 
            
            Provider.of<_MenuModel>(context).backgroundColor = backgroundColor;
            Provider.of<_MenuModel>(context).activeColor     = activeColor;
            Provider.of<_MenuModel>(context).inactiveColor   = inactiveColor;
            
            return _PinterestMenuBackground(
              child: _MenuItems(menuItems: items),
            );
          }
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

    Color backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(        
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor, 
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        boxShadow: const <BoxShadow>[
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

    final menuModel = Provider.of<_MenuModel>(context);


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
            ? menuModel.activeColor 
            : menuModel.inactiveColor,
        ),
      ),
    );
  }
}


class _MenuModel with ChangeNotifier {
  int _selectedItem = 0;

  Color backgroundColor = Colors.white;
  Color activeColor     = Colors.black;
  Color inactiveColor   = Colors.blue;

  int get selectedItem => _selectedItem;

  set selectedItem(int index) {
    _selectedItem = index;
    notifyListeners();
  }


}