import 'package:flutter/material.dart';
import 'package:money_manager/utils/countries/countries.dart';
import 'package:money_manager/utils/countries/country.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/utils/utils.dart';

/// Created by Huan.Huynh on 2019-07-12.
///
/// Copyright © 2019 teqnological. All rights reserved.

/// Returns true when a country should be included in lists / dialogs
/// offered to the user.
typedef bool ItemFilter(Country country);

typedef Widget ItemBuilder(Country country);

/// Simple closure which always returns true.
bool acceptAllCountries(_) => true;

class CountryPickerDialog extends StatefulWidget {

  final String selected;
  final double itemHeight;
  final ItemFilter itemFilter;
  
  const CountryPickerDialog({
    Key key,
    @required this.selected,
    this.itemFilter,
    this.itemHeight = 60,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CountryPickerDialogState();
}

class CountryPickerDialogState extends State<CountryPickerDialog>
  with TickerProviderStateMixin {

  // Animation
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimation;

  List<Country> _allCountries;
  List<Country> _filteredCountries;

  @override
  void initState() {
    _allCountries = countryList
      .where(widget.itemFilter ?? acceptAllCountries)
      .toList();

    _filteredCountries = _allCountries;

    super.initState();

    controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimation =
      CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final realHeight = _filteredCountries.length * widget.itemHeight + 106;
    final height = MediaQuery.of(context).size.height * 0.7;
    return Material(
      color: Colors.black.withOpacity(opacityAnimation.value),
      child: Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
            padding: const EdgeInsets.all(16),
            height: realHeight > height ? height : realHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  offset: Offset(0, 6),
                  blurRadius: 15,
                  spreadRadius: 0
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Select currency', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                TextField(
                  decoration:
                  InputDecoration(hintText: 'Search by name or currency'),
                  onChanged: (String value) {
                    setState(() {
                      _filteredCountries = _allCountries
                        .where((Country country) =>
                      country.name.toLowerCase().startsWith(value.toLowerCase()) ||
                        country.currency.startsWith(value) ||
                        country.isoCode.toLowerCase().startsWith(value.toLowerCase()))
                        .toList();
                    });
                  },
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).pop(_filteredCountries[index]),
                        child: Container(
                          height: 60,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(width: 0.2,),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: SizedBox(
                                    width: 60, height: 40,
                                    child: CountryPickerUtils.getDefaultFlagImage(_filteredCountries[index])),
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_filteredCountries[index].name, style: TextStyle(fontSize: 16),),
                                  Text(_filteredCountries[index].currency, style: TextStyle(fontSize: 12, color: Colors.grey),),
                                ],
                              )),
                              Text(_filteredCountries[index].symbol, style: TextStyle(fontSize: 16),),
                              SizedBox(width: 4,),
                              _filteredCountries[index].isoCode == widget.selected
                                ? Icon(Icons.check_circle, color: MyColors.primaryGreen, size: 20,)
                              : Container(width: 20,),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 0.3, color: Colors.grey, indent: 8,),
                    itemCount: _filteredCountries.length
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}