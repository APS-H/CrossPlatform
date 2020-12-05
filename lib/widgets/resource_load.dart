import 'package:crossplatform/common/helpers.dart';
import 'package:crossplatform/common/colors.dart';
import 'package:crossplatform/models/models.dart';
import 'package:crossplatform/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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

  final ResourceLoadDataSource _resourceLoadDataSource =
      ResourceLoadDataSource();

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
        PaginatedDataTable(
          showCheckboxColumn: false,
          availableRowsPerPage: _availableRowsPerPage,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.add),
            //   tooltip: '新增资源',
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: Icon(Icons.edit),
            //   tooltip: '修改资源',
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: Icon(Icons.delete),
            //   tooltip: '删除资源',
            //   onPressed: () {},
            // ),
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

class ResourceLoadDataSource extends DataTableSource {
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
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('${resource.name}'), onTap: () {}),
      ...resource.loadList.map(_transform),
    ]);
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
