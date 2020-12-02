import 'package:crossplatform/models/models.dart';
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
/*ascending 上升 这里排序 没看懂比较的是个啥*/
  void _sort<T>(Comparable<T> getField(ResourceLoad d), bool ascending) {
    desserts.sort((ResourceLoad a, ResourceLoad b) {
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
    if (index >= desserts.length) return null;
    final ResourceLoad dessert = desserts[index];
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
  int get rowCount => desserts.length;

  // TODO: implement selectedRowCount
  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (ResourceLoad dessert in desserts) dessert.selected = checked;
    _selectedCount = checked ? desserts.length : 0;
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
