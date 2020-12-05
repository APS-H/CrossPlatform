import 'package:crossplatform/common/colors.dart';
import 'package:crossplatform/common/helpers.dart';
import 'package:crossplatform/models/models.dart';
import 'package:crossplatform/models/order.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OrderDetailChart extends StatefulWidget {
  const OrderDetailChart({this.defaultDate});

  final DateTime defaultDate;

  @override
  _OrderDetailChartState createState() => _OrderDetailChartState();
}

class _OrderDetailChartState extends State<OrderDetailChart> {
  int _rowsPerPage = 15;
  final _availableRowsPerPage = [10, 15, 20, 30, 50];

  int _sortColumnIndex;
  bool _sortAscending = true;

  final OrderDataSource _ordersDataSource = OrderDataSource();
  DateTime _currentDate;

  @override
  void initState() {
    this._currentDate = widget.defaultDate ?? DateTime(2020, 11, 1);
    super.initState();
  }

  void _sort<T>(
      Comparable<T> getField(OrderData d), int columnIndex, bool ascending) {
    _ordersDataSource._sort<T>(getField, ascending);
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
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              tooltip: '往前一天',
              onPressed: () {
                setState(() {
                  _currentDate = _currentDate.subtract(new Duration(days: 1));
                });
              },
            ),
            Text('${dateString(_currentDate)}'),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              tooltip: '往后一天',
              onPressed: () {
                setState(() {
                  _currentDate = _currentDate.add(new Duration(days: 1));
                });
              },
            ),
          ],
          header: Row(
            children: [
              Text('订单甘特图'),
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
                label: const Text('订单编号'),
                tooltip: '订单编号',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (OrderData d) => d.id, columnIndex, ascending)),
            DataColumn(
                label: const Text('订单进度'),
                tooltip: '${dateString(_currentDate)} 订单进度',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (OrderData d) => d.crafts[0].percent,
                    columnIndex,
                    ascending)),
          ],
          source: _ordersDataSource,
        ),
      ],
    );
  }
}

class OrderDataSource extends DataTableSource {
  void _sort<T>(Comparable<T> getField(OrderData d), bool ascending) {
    orders.sort((OrderData a, OrderData b) {
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

  Widget _buildCell(OrderData data) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          ...data.crafts.map((craft) => Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: LinearPercentIndicator(
                  width: 600,
                  lineHeight: 30.0,
                  animation: true,
                  animationDuration: 500,
                  percent: craft.percent,
                  center: Text('${craft.name} ${craft.percent * 100}%'),
                  progressColor: _progressColor(craft.percent * 100),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                ),
              ))
        ],
      ),
    );
  }

  @override
  DataRow getRow(int index) {
    if (index >= orders.length) return null;
    final OrderData order = orders[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('订单${order.id}'), onTap: () {}),
      DataCell(_buildCell(order), onTap: () {}),
    ]);
  }

  Color _progressColor(double progress) {
    int i = (progress / 20).truncate();
    int len = progressColors.length;
    return progressColors[i >= len ? len - 1 : i];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => resources.length;

  int get selectedRowCount => 0;
}

class OrderDetailTable extends StatefulWidget {
  @override
  _OrderDetailTableState createState() => _OrderDetailTableState();
}

class _OrderDetailTableState extends State<OrderDetailTable> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Order Detail Table'));
  }
}
