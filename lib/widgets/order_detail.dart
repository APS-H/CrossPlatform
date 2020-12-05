import 'package:crossplatform/common/colors.dart';
import 'package:crossplatform/common/helpers.dart';
import 'package:crossplatform/models/mock.dart';
import 'package:crossplatform/models/order.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OrderProgressChart extends StatefulWidget {
  const OrderProgressChart({this.defaultDate});

  final DateTime defaultDate;

  @override
  _OrderProgressChartState createState() => _OrderProgressChartState();
}

class _OrderProgressChartState extends State<OrderProgressChart> {
  int _rowsPerPage = 15;
  final _availableRowsPerPage = [10, 15, 20, 30, 50];

  int _sortColumnIndex;
  bool _sortAscending = true;

  final OrderProgressDataSource _ordersDataSource = OrderProgressDataSource();
  DateTime _currentDate;

  @override
  void initState() {
    this._currentDate = widget.defaultDate ?? DateTime(2020, 11, 1);
    super.initState();
  }

  void _sort<T>(Comparable<T> getField(OrderProgress d), int columnIndex,
      bool ascending) {
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
                    (OrderProgress d) => d.id, columnIndex, ascending)),
            DataColumn(
                label: const Text('订单进度'),
                tooltip: '${dateString(_currentDate)} 订单进度',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (OrderProgress d) => d.crafts[0].percent,
                    columnIndex,
                    ascending)),
          ],
          source: _ordersDataSource,
        ),
      ],
    );
  }
}

class OrderTable extends StatefulWidget {
  @override
  _OrderTableState createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  int _rowsPerPage = 15;
  final _availableRowsPerPage = [10, 15, 20, 30, 50];

  int _sortColumnIndex;
  bool _sortAscending = true;

  final _orderDataSource = OrderDataSource(orders);

  void _sort<T>(
      Comparable<T> getField(Order d), int columnIndex, bool ascending) {
    _orderDataSource._sort<T>(getField, ascending);
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
              tooltip: '新增订单',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: '修改订单',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: '删除订单',
              onPressed: () {},
            ),
          ],
          header: Row(
            children: [
              Text('订单列表'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
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
          onSelectAll: _orderDataSource._selectAll,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('订单编号'),
                tooltip: '订单编号',
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((Order d) => d.id, columnIndex, ascending)),
            DataColumn(
                label: const Text('产品编号'),
                tooltip: '订单生产产品的物料编号',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Order d) => d.productID, columnIndex, ascending)),
            DataColumn(
                label: const Text('产品数量'),
                tooltip: '订单要求生产并交付产品的数量',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Order d) => d.productCount.toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('交付日期'),
                tooltip: '约定产品交付日期',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Order d) => dateString(d.deliveryDate),
                    columnIndex,
                    ascending)),
          ],
          source: _orderDataSource,
        ),
      ],
    );
  }
}

class OrderProgressDataSource extends DataTableSource {
  void _sort<T>(Comparable<T> getField(OrderProgress d), bool ascending) {
    ordersProgress.sort((OrderProgress a, OrderProgress b) {
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

  Widget _buildCell(OrderProgress data) {
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
    if (index >= ordersProgress.length) return null;
    final OrderProgress order = ordersProgress[index];
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

class OrderDataSource extends DataTableSource {
  OrderDataSource(this.orders);

  List<Order> orders;
  int _selectedCount = 0;

  void _sort<T>(Comparable<T> getField(Order d), bool ascending) {
    orders.sort((Order a, Order b) {
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

  @override
  DataRow getRow(int index) {
    if (index >= orders.length) return null;
    final Order order = orders[index];
    return DataRow.byIndex(
      index: index,
      selected: order.selected,
      onSelectChanged: (bool value) {
        if (order.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          order.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text('${order.id}')),
        DataCell(Text('${order.productID}')),
        DataCell(Text('${order.productCount}')),
        DataCell(Text('${dateString(order.deliveryDate)}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Order r in orders) r.selected = checked;
    _selectedCount = checked ? orders.length : 0;
    notifyListeners();
  }
}
