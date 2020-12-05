import 'dart:math';

import 'package:crossplatform/common/helpers.dart';
import 'package:crossplatform/common/colors.dart';
import 'package:crossplatform/models/mock.dart';
import 'package:crossplatform/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quiver/iterables.dart';

class ResourceLoadSummary extends StatelessWidget {
  const ResourceLoadSummary(this._dataSource);

  final ResourceLoadDataSource _dataSource;

  double _getLoadSummary(ResourceType type) {
    int count = 0;
    double load = 0;
    for (ResourceLoad rl in _dataSource.resources) {
      if (rl.type == type) {
        count += rl.loadList.length;
        load += rl.loadList.reduce((value, element) => value + element);
      }
    }
    if (count == 0) return 0.0;
    final s = load / count;
    return s > 1.0 ? 1.0 : s;
  }

  List<Widget> _colorLegend() {
    List<Padding> legend = [];
    for (int i = 0; i < progressColors.length; i++) {
      legend.add(Padding(
        padding: EdgeInsets.all(10),
        child: LinearPercentIndicator(
          width: 85,
          lineHeight: 30.0,
          animation: false,
          percent: 1.0,
          center: i == progressColors.length - 1
              ? Text('>100%')
              : Text('${i * 20}~${(i + 1) * 20}%'),
          progressColor: progressColors[i],
          linearStrokeCap: LinearStrokeCap.roundAll,
        ),
      ));
    }
    return legend;
  }

  Color _progressColor(double loadRate) {
    int i = (loadRate * 5).truncate();
    int len = progressColors.length;
    return progressColors[i >= len ? len - 1 : i];
  }

  @override
  Widget build(BuildContext context) {
    final humanLoadSummary = _getLoadSummary(ResourceType.humanResource);
    final equipmentLoadSummary =
        _getLoadSummary(ResourceType.equipmentResource);

    return Card(
      child: Container(
        // width: 300,
        // height: 100,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '资源总负载',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  ..._colorLegend(),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 18.0,
                      animation: true,
                      percent: humanLoadSummary,
                      center: Text(
                        "${humanLoadSummary * 100}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "人力总负载",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: _progressColor(humanLoadSummary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 18.0,
                      animation: true,
                      percent: equipmentLoadSummary,
                      center: Text(
                        "${equipmentLoadSummary * 100}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "设备总负载",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: _progressColor(equipmentLoadSummary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResourceLoadChart extends StatefulWidget {
  const ResourceLoadChart({this.defaultStartDate, this.defaultEndDate});

  final DateTime defaultStartDate;
  final DateTime defaultEndDate;

  @override
  State<StatefulWidget> createState() => _ResourceLoadChartState();
}

class _ResourceLoadChartState extends State<ResourceLoadChart> {
  int _rowsPerPage = 15;
  final _availableRowsPerPage = [10, 15, 20, 30, 50];

  int _sortColumnIndex;
  bool _sortAscending = true;

  DateTime _startDate;
  DateTime _endDate;

  final _resourceLoadDataSource = ResourceLoadDataSource(resources);

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
          label: Text(dateString(currentDate)),
          tooltip: '${dateString(currentDate)} 人力/设备资源负载率',
          numeric: true,
          onSort: (int columnIndex, bool ascending) => _sort<num>(
              (ResourceLoad d) => d.loadList[columnIndex - 1],
              columnIndex,
              ascending)));
      currentDate = currentDate.add(new Duration(days: 1));
    }
    return columns;
  }

  void _sort<T>(
      Comparable<T> getField(ResourceLoad d), int columnIndex, bool ascending) {
    _resourceLoadDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<Widget> _colorLegend() {
    List<Padding> legend = [];
    for (int i = 0; i < progressColors.length; i++) {
      legend.add(Padding(
        padding: EdgeInsets.all(10),
        child: LinearPercentIndicator(
          width: 85,
          lineHeight: 30.0,
          animation: false,
          percent: 1.0,
          center: i == progressColors.length - 1
              ? Text('>100%')
              : Text('${i * 20}~${(i + 1) * 20}%'),
          progressColor: progressColors[i],
          linearStrokeCap: LinearStrokeCap.roundAll,
        ),
      ));
    }
    return legend;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        ResourceLoadSummary(_resourceLoadDataSource),
        PaginatedDataTable(
          showCheckboxColumn: false,
          availableRowsPerPage: _availableRowsPerPage,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              tooltip: '往前一天',
              onPressed: () {
                setState(() {
                  _startDate = _startDate.subtract(new Duration(days: 1));
                  _endDate = _endDate.subtract(new Duration(days: 1));
                });
              },
            ),
            Text(
                '${dateString(_startDate)} ~ ${dateString(_endDate.subtract(new Duration(days: 1)))}'),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              tooltip: '往后一天',
              onPressed: () {
                setState(() {
                  _startDate = _startDate.add(new Duration(days: 1));
                  _endDate = _endDate.add(new Duration(days: 1));
                });
              },
            ),
          ],
          header: Row(
            children: [
              Text('资源负载图'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
              ..._colorLegend(),
            ],
          ),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('资源名称'),
                tooltip: '人力/设备资源名称',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (ResourceLoad d) => d.name, columnIndex, ascending)),
            ..._columns(),
          ],
          source: _resourceLoadDataSource,
        ),
      ],
    );
  }
}

class HumanResourceTable extends StatefulWidget {
  @override
  _HumanResourceTableState createState() => _HumanResourceTableState();
}

class _HumanResourceTableState extends State<HumanResourceTable> {
  int _rowsPerPage = 15;
  final _availableRowsPerPage = [10, 15, 20, 30, 50];

  int _sortColumnIndex;
  bool _sortAscending = true;

  final _humanResourceDataSource = ResourceDataSource(humanResources);

  List<Widget> _shiftLegend() {
    return [
      ...shiftMap.values.map((e) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                '${e.name}: ${timeString(e.startTime)}~${timeString(e.endTime)}'),
          ))
    ];
  }

  void _sort<T>(
      Comparable<T> getField(Resource d), int columnIndex, bool ascending) {
    _humanResourceDataSource._sort<T>(getField, ascending);
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
          showCheckboxColumn: true,
          availableRowsPerPage: _availableRowsPerPage,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              tooltip: '新增资源',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: '修改资源',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: '删除资源',
              onPressed: () {},
            ),
          ],
          header: Row(
            children: [
              Text('人力资源列表'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
              ..._shiftLegend(),
            ],
          ),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          onSelectAll: _humanResourceDataSource._selectAll,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('人组名称'),
                tooltip: '人力资源组名称',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.name, columnIndex, ascending)),
            DataColumn(
                label: const Text('组人数'),
                tooltip: '人力资源组人数',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.count.toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('排班类型'),
                tooltip: '人力资源组排班（早班、晚班、全天）',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.shift.toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周一'),
                tooltip: '人力资源组周一是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(1).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周二'),
                tooltip: '人力资源组周二是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(2).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周三'),
                tooltip: '人力资源组周三是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(3).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周四'),
                tooltip: '人力资源组周四是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(4).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周五'),
                tooltip: '人力资源组周五是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(5).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周六'),
                tooltip: '人力资源组周六是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(6).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周日'),
                tooltip: '人力资源组周日是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(7).toString(),
                    columnIndex,
                    ascending)),
          ],
          source: _humanResourceDataSource,
        ),
      ],
    );
  }
}

class EquipmentResourceTable extends StatefulWidget {
  @override
  _EquipmentResourceTableState createState() => _EquipmentResourceTableState();
}

class _EquipmentResourceTableState extends State<EquipmentResourceTable> {
  int _rowsPerPage = 15;
  final _availableRowsPerPage = [10, 15, 20, 30, 50];

  int _sortColumnIndex;
  bool _sortAscending = true;

  final _equipmentResourceDataSource = ResourceDataSource(equipmentResource);

  List<Widget> _shiftLegend() {
    return [
      ...shiftMap.values.map((e) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                '${e.name}: ${timeString(e.startTime)}~${timeString(e.endTime)}'),
          ))
    ];
  }

  void _sort<T>(
      Comparable<T> getField(Resource d), int columnIndex, bool ascending) {
    _equipmentResourceDataSource._sort<T>(getField, ascending);
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
          showCheckboxColumn: true,
          availableRowsPerPage: _availableRowsPerPage,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              tooltip: '新增资源',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: '修改资源',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: '删除资源',
              onPressed: () {},
            ),
          ],
          header: Row(
            children: [
              Text('设备资源列表'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
              ..._shiftLegend(),
            ],
          ),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          onSelectAll: _equipmentResourceDataSource._selectAll,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('设备名称'),
                tooltip: '设备资源名称',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.name, columnIndex, ascending)),
            DataColumn(
                label: const Text('设备数量'),
                tooltip: '设备资源数量',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.count.toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('排班类型'),
                tooltip: '设备资源排班（早班、晚班、全天）',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.shift.toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周一'),
                tooltip: '设备资源周一是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(1).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周二'),
                tooltip: '设备资源周二是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(2).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周三'),
                tooltip: '设备资源周三是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(3).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周四'),
                tooltip: '设备资源周四是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(4).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周五'),
                tooltip: '设备资源周五是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(5).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周六'),
                tooltip: '设备资源周六是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(6).toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('周日'),
                tooltip: '设备资源周日是否工作',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Resource d) => d.workDays.contains(7).toString(),
                    columnIndex,
                    ascending)),
          ],
          source: _equipmentResourceDataSource,
        ),
      ],
    );
  }
}

class ResourceLoadDataSource extends DataTableSource {
  ResourceLoadDataSource(this.resources);

  List<ResourceLoad> resources;

  void _sort<T>(Comparable<T> getField(ResourceLoad d), bool ascending) {
    resources.sort((ResourceLoad a, ResourceLoad b) {
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

  @override
  DataRow getRow(int index) {
    if (index >= resources.length) return null;
    final ResourceLoad resource = resources[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${resource.name}'), onTap: () {}),
        ...resource.loadList.map(_transform),
      ],
    );
  }

  Color _progressColor(double loadRate) {
    int i = (loadRate / 20).truncate();
    int len = progressColors.length;
    return progressColors[i >= len ? len - 1 : i];
  }

  DataCell _transform(double loadRate) {
    double percent = loadRate / 100;
    String centerStr = '$loadRate%';

    return DataCell(
      LinearPercentIndicator(
        width: 200,
        lineHeight: 30.0,
        animation: true,
        animationDuration: 500,
        percent: percent > 1.0 ? 1.0 : percent,
        center: Text(centerStr),
        progressColor: _progressColor(loadRate),
        linearStrokeCap: LinearStrokeCap.roundAll,
      ),
      onTap: () {},
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => resources.length;

  @override
  int get selectedRowCount => 0;
}

class ResourceDataSource extends DataTableSource {
  ResourceDataSource(this.resources);

  List<Resource> resources;
  int _selectedCount = 0;

  void _sort<T>(Comparable<T> getField(Resource d), bool ascending) {
    resources.sort((Resource a, Resource b) {
      if (!ascending) {
        final c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  List<DataCell> _workDays(List<int> workDays) {
    List<DataCell> row = [];
    for (int i = 1; i <= 7; i++) {
      row.add(
          workDays.contains(i) ? DataCell(Icon(Icons.check)) : DataCell.empty);
    }
    return row;
  }

  @override
  DataRow getRow(int index) {
    if (index >= resources.length) return null;
    final Resource resource = resources[index];
    return DataRow.byIndex(
      index: index,
      selected: resource.selected,
      onSelectChanged: (bool value) {
        if (resource.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          resource.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text('${resource.name}')),
        DataCell(Text('${resource.count}')),
        DataCell(Text('${shiftMap[resource.shift].name}')),
        ..._workDays(resource.workDays),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => resources.length;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Resource r in resources) r.selected = checked;
    _selectedCount = checked ? resources.length : 0;
    notifyListeners();
  }
}
