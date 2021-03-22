import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'destination.dart';

int indexSelected = 0;
bool isMenuOpen = false;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(builder: (context, dimens) {
              return Scaffold(
                bottomNavigationBar: dimens.maxWidth <= dimens.maxHeight
                    ? BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: indexSelected,
                        onTap: (int index) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            indexSelected = index;
                          });
                        },
                        items: allDestinations.map((destination) {
                          return BottomNavigationBarItem(
                              tooltip: destination.tooltip,
                              icon: Stack(
                                children: <Widget>[
                                  Icon(destination.icon),
                                ],
                              ),
                              label: '');
                        }).toList(),
                      )
                    : null,
                body: Row(
                  children: [
                    _leftMenu(dimens),
                    VerticalDivider(
                      width: 0.1,
                    ),
                    Expanded(child: _buildBody()),
                  ],
                ),
              );
            })));
  }

  void _onTap(int index) {
    FocusScope.of(context).unfocus();
    if (mounted)
      setState(() {
        indexSelected = index;
      });
  }

  _buildBody() {
    return ClipRect(
      child: SafeArea(
        top: false,
        child: IndexedStack(
          index: indexSelected,
          children: allDestinations.map<Widget>((destination) {
            return destination.pagina;
          }).toList(),
        ),
      ),
    );
  }

  _leftMenu(BoxConstraints dimens) {
    if (dimens.maxWidth > dimens.maxHeight) {
      return _navigationRail(context, dimens, _onTap);
    } else {
      return SizedBox();
    }
  }

  _navigationRail(context, dimens, onTap) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: dimens.maxHeight - 56.0),
          child: IntrinsicHeight(
            child: Material(
              child: NavigationRail(
                  backgroundColor: Colors.transparent,
                  labelType: NavigationRailLabelType.none,
                  // unselectedIconTheme: IconThemeData(color: Colors.grey[800]),
                  selectedIndex: indexSelected,
                  onDestinationSelected: onTap,
                  destinations: allDestinations.map((destination) {
                    return NavigationRailDestination(
                        label: Text(destination.tooltip),
                        icon: Icon(destination.icon));
                  }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}
