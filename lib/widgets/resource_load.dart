import 'package:crossplatform/models/resource.dart';
import 'package:flutter/material.dart';

class ResourceLoadChart extends StatefulWidget {
  const ResourceLoadChart({this.defaultStartDate, this.defaultEndDate});

  final DateTime defaultStartDate;
  final DateTime defaultEndDate;

  @override
  State<StatefulWidget> createState() => _ResourceLoadChartState();
}

class _ResourceLoadChartState extends State<ResourceLoadChart> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  int _sortColumnIndex;
  bool _sortAscending = true;

  DateTime _startDate;
  DateTime _endDate;

  @override
  void initState() {
    this._startDate = widget.defaultStartDate ?? DateTime(2020, 11, 1);
    this._endDate = widget.defaultEndDate ?? DateTime(2020, 11, 8);
    super.initState();
  }

  List<DataColumn> _columns() {
    DateTime currentDate = _startDate;
    List<DataColumn> columns = [];
    while (currentDate.isBefore(_endDate)) {
      columns.add(DataColumn(
          label: Text(
              '${currentDate.year}-${currentDate.month}-${currentDate.day}'),
          tooltip:
              'Resource load rate of ${currentDate.year}-${currentDate.month}-${currentDate.day}',
          numeric: true,
          onSort: (int columnIndex, bool ascending) => _sort<num>(
              (ResourceLoad d) => d.loadList[columnIndex - 1],
              columnIndex,
              ascending)));
      currentDate = currentDate.add(new Duration(days: 1));
    }
    return columns;
  }

  /*数据源*/
  final DessertDataSource _dessertsDataSource = DessertDataSource();

  void _sort<T>(
      Comparable<T> getField(ResourceLoad d), int columnIndex, bool ascending) {
    _dessertsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        PaginatedDataTable(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              tooltip: '新增资源',
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: '修改资源',
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: '删除资源',
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              tooltip: '往后一天',
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              tooltip: '往前一天',
              onPressed: () {},
            ),
          ],
          header: const Text('资源负载图'),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          /*当前主排序的列的index*/
          sortAscending: _sortAscending,
          onSelectAll: _dessertsDataSource._selectAll,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('资源名称'),
                tooltip: '人力/设备资源名称',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (ResourceLoad d) => d.name, columnIndex, ascending)),
            ..._columns(),
          ],
          source: _dessertsDataSource,
        ),
      ],
    );
  }
}

class DessertDataSource extends DataTableSource {
  /*数据源*/
  final List<ResourceLoad> _desserts = <ResourceLoad>[
    ResourceLoad('Frozen yogurt', [159, 6.0, 24, 4.0, 87, 14, 1]),
    ResourceLoad('Ice cream sandwich', [237, 9.0, 37, 4.3, 129, 8, 1]),
    ResourceLoad('Eclair', [262, 16.0, 24, 6.0, 337, 6, 7]),
    ResourceLoad('Cupcake', [305, 3.7, 67, 4.3, 413, 3, 8]),
    ResourceLoad('Gingerbread', [356, 16.0, 49, 3.9, 327, 7, 16]),
    ResourceLoad('Jelly bean', [375, 0.0, 94, 0.0, 50, 0, 0]),
    ResourceLoad('Lollipop', [392, 0.2, 98, 0.0, 38, 0, 2]),
    ResourceLoad('Honeycomb', [408, 3.2, 87, 6.5, 562, 0, 45]),
    ResourceLoad('Donut', [452, 25.0, 51, 4.9, 326, 2, 22]),
    ResourceLoad('KitKat', [518, 26.0, 65, 7.0, 54, 12, 6]),
    ResourceLoad('Frozen yogurt with sugar', [168, 6.0, 26, 4.0, 87, 14, 1]),
    ResourceLoad(
        'Ice cream sandwich with sugar', [246, 9.0, 39, 4.3, 129, 8, 1]),
    ResourceLoad('Eclair with sugar', [271, 16.0, 26, 6.0, 337, 6, 7]),
    ResourceLoad('Cupcake with sugar', [314, 3.7, 69, 4.3, 413, 3, 8]),
    ResourceLoad('Gingerbread with sugar', [345, 16.0, 51, 3.9, 327, 7, 16]),
    ResourceLoad('Jelly bean with sugar', [364, 0.0, 96, 0.0, 50, 0, 0]),
    ResourceLoad('Lollipop with sugar', [401, 0.2, 100, 0.0, 38, 0, 2]),
    ResourceLoad('Honeycomb with sugar', [417, 3.2, 89, 6.5, 562, 0, 45]),
    ResourceLoad('Donut with sugar', [461, 25.0, 53, 4.9, 326, 2, 22]),
    ResourceLoad('KitKat with sugar', [527, 26.0, 67, 7.0, 54, 12, 6]),
    ResourceLoad('Frozen yogurt with honey', [223, 6.0, 36, 4.0, 87, 14, 1]),
    ResourceLoad(
        'Ice cream sandwich with honey', [301, 9.0, 49, 4.3, 129, 8, 1]),
    ResourceLoad('Eclair with honey', [326, 16.0, 36, 6.0, 337, 6, 7]),
    ResourceLoad('Cupcake with honey', [369, 3.7, 79, 4.3, 413, 3, 8]),
    ResourceLoad('Gingerbread with honey', [420, 16.0, 61, 3.9, 327, 7, 16]),
    ResourceLoad('Jelly bean with honey', [439, 0.0, 106, 0.0, 50, 0, 0]),
    ResourceLoad('Lollipop with honey', [456, 0.2, 110, 0.0, 38, 0, 2]),
    ResourceLoad('Honeycomb with honey', [472, 3.2, 99, 6.5, 562, 0, 45]),
    ResourceLoad('Donut with honey', [516, 25.0, 63, 4.9, 326, 2, 22]),
    ResourceLoad('KitKat with honey', [582, 26.0, 77, 7.0, 54, 12, 6]),
    ResourceLoad('Frozen yogurt with milk', [262, 8.4, 36, 12.0, 194, 44, 1]),
    ResourceLoad(
        'Ice cream sandwich with milk', [339, 11.4, 49, 12.3, 236, 38, 1]),
    ResourceLoad('Eclair with milk', [365, 18.4, 36, 14.0, 444, 36, 7]),
    ResourceLoad('Cupcake with milk', [408, 6.1, 79, 12.3, 520, 33, 8]),
    ResourceLoad('Gingerbread with milk', [459, 18.4, 61, 11.9, 434, 37, 16]),
    ResourceLoad('Jelly bean with milk', [478, 2.4, 106, 8.0, 157, 30, 0]),
    ResourceLoad('Lollipop with milk', [495, 2.6, 110, 8.0, 145, 30, 2]),
    ResourceLoad('Honeycomb with milk', [511, 5.6, 99, 14.5, 669, 30, 45]),
    ResourceLoad('Donut with milk', [555, 27.4, 63, 12.9, 433, 32, 22]),
    ResourceLoad('KitKat with milk', [621, 28.4, 77, 15.0, 161, 42, 6]),
    ResourceLoad(
        'Coconut slice and frozen yogurt', [318, 21.0, 31, 5.5, 96, 14, 7]),
    ResourceLoad('Coconut slice and ice cream sandwich',
        [396, 24.0, 44, 5.8, 138, 8, 7]),
    ResourceLoad('Coconut slice and eclair', [421, 31.0, 31, 7.5, 346, 6, 13]),
    ResourceLoad('Coconut slice and cupcake', [464, 18.7, 74, 5.8, 422, 3, 14]),
    ResourceLoad(
        'Coconut slice and gingerbread', [515, 31.0, 56, 5.4, 316, 7, 22]),
    ResourceLoad(
        'Coconut slice and jelly bean', [534, 15.0, 101, 1.5, 59, 0, 6]),
    ResourceLoad('Coconut slice and lollipop', [551, 15.2, 105, 1.5, 47, 0, 8]),
    ResourceLoad(
        'Coconut slice and honeycomb', [567, 18.2, 94, 8.0, 571, 0, 51]),
    ResourceLoad('Coconut slice and donut', [611, 40.0, 58, 6.4, 335, 2, 28]),
    ResourceLoad('Coconut slice and KitKat', [677, 41.0, 72, 8.5, 63, 12, 12]),
  ];

/*ascending 上升 这里排序 没看懂比较的是个啥*/
  void _sort<T>(Comparable<T> getField(ResourceLoad d), bool ascending) {
    _desserts.sort((ResourceLoad a, ResourceLoad b) {
      if (!ascending) {
        final ResourceLoad c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    if (index >= _desserts.length) return null;
    final ResourceLoad dessert = _desserts[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${dessert.name}')),
          ...dessert.loadList.map((e) => DataCell(Text('$e'))),
        ]);
  }

  // TODO: implement isRowCountApproximate
  @override
  bool get isRowCountApproximate => false;

  // TODO: implement rowCount
  @override
  int get rowCount => _desserts.length;

  // TODO: implement selectedRowCount
  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (ResourceLoad dessert in _desserts) dessert.selected = checked;
    _selectedCount = checked ? _desserts.length : 0;
    notifyListeners();
  }
}

class ResourceLoadHumanTable extends StatefulWidget {
  @override
  _ResourceLoadHumanTableState createState() => _ResourceLoadHumanTableState();
}

class _ResourceLoadHumanTableState extends State<ResourceLoadHumanTable> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Resource Load Human Table'));
  }
}

class ResourceLoadEquipmentTable extends StatefulWidget {
  @override
  _ResourceLoadEquipmentTableState createState() =>
      _ResourceLoadEquipmentTableState();
}

class _ResourceLoadEquipmentTableState
    extends State<ResourceLoadEquipmentTable> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Resource Load Equipment Table'));
  }
}
