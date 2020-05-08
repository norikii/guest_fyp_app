import 'package:flutter/material.dart';
import 'package:guest_fyp_app/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const settingsScreenRoute = '/settings';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  SettingsScreen(this.currentFilters, this.saveFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget buildSwitchList(String title, String subtitle, bool currentValue, Function updatedValue) {
    return
        SwitchListTile(
          title: Text(title),
          value: currentValue,
          subtitle: Text(subtitle),
          onChanged: updatedValue,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Configuration'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: () {
            final selectedFilters = {
            'gluten': _glutenFree,
            'lactose': _lactoseFree,
            'vegan': _vegan,
            'vegetarian': _vegetarian,
            };
            widget.saveFilters(selectedFilters);
          },)
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adhust your meal selection', style: Theme.of(context).textTheme.title,),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchList('Gluten-free', 'Only include gluten-free itmes', _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwitchList('Vegetarian', 'Only include vegetarian itmes', _vegetarian, (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                buildSwitchList('Vegan', 'Only include vegan itmes', _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                buildSwitchList('Lactose-free', 'Only include lactose-free itmes', _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
              ],
            ),
          )
        ],

      ),
    );
  }
}
