import 'package:crossplatform/models/mock.dart';
import 'package:crossplatform/models/schedule.dart';
import 'package:crossplatform/common/helpers.dart';
import 'package:flutter/material.dart';

class ScheduleDetailOrderPlanTable extends StatefulWidget {
  @override
  _ScheduleDetailOrderPlanTableState createState() =>
      _ScheduleDetailOrderPlanTableState();
}

class _ScheduleDetailOrderPlanTableState
    extends State<ScheduleDetailOrderPlanTable> {
  int _sortColumnIndex;
  bool _sortAscending = true;

  final _orderPlanDataSource = OrderPlanDataSource(orderPlans);

  void _sort<T>(
      Comparable<T> getField(OrderPlan d), int columnIndex, bool ascending) {
    _orderPlanDataSource._sort<T>(getField, ascending);
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
          showCheckboxColumn: false,
          dataRowHeight: 120,
          actions: <Widget>[],
          header: Row(
            children: [
              Text('订单计划列表'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
            ],
          ),
          rowsPerPage: _orderPlanDataSource.orderPlans.length,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('订单编号'),
                tooltip: '订单编号',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (OrderPlan d) => d.orderId, columnIndex, ascending)),
            DataColumn(
                label: const Text('产品数量'),
                tooltip: '订单生产产品数量',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (OrderPlan d) => d.productNum.toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('生产计划'),
                tooltip: '订单具体的生产安排详情',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (OrderPlan d) => d.schedules[0].id.toString(),
                    columnIndex,
                    ascending)),
          ],
          source: _orderPlanDataSource,
        ),
      ],
    );
  }
}

class ScheduleDetailOrderProductionTable extends StatefulWidget {
  @override
  _ScheduleDetailOrderProductionTableState createState() =>
      _ScheduleDetailOrderProductionTableState();
}

class _ScheduleDetailOrderProductionTableState
    extends State<ScheduleDetailOrderProductionTable> {
  int _sortColumnIndex;
  bool _sortAscending = true;

  final _orderProductionDataSource =
      OrderProductionDataSource(orderProductions);

  void _sort<T>(Comparable<T> getField(OrderProduction d), int columnIndex,
      bool ascending) {
    _orderProductionDataSource._sort<T>(getField, ascending);
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
          showCheckboxColumn: false,
          actions: <Widget>[],
          header: Row(
            children: [
              Text('订单-生产单关系表'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
            ],
          ),
          rowsPerPage: _orderProductionDataSource.orderProductions.length,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('订单编号'),
                tooltip: '订单编号',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (OrderProduction d) => d.orderID, columnIndex, ascending)),
            DataColumn(
                label: const Text('生产单编号'),
                tooltip: '生产单编号',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (OrderProduction d) => d.productionID,
                    columnIndex,
                    ascending)),
          ],
          source: _orderProductionDataSource,
        ),
      ],
    );
  }
}

class ScheduleDetailProductionTable extends StatefulWidget {
  @override
  _ScheduleDetailProductionTableState createState() =>
      _ScheduleDetailProductionTableState();
}

class _ScheduleDetailProductionTableState
    extends State<ScheduleDetailProductionTable> {
  int _sortColumnIndex;
  bool _sortAscending = true;

  final _productionDataSource = ProductionDataSource(productions);

  void _sort<T>(
      Comparable<T> getField(Production d), int columnIndex, bool ascending) {
    _productionDataSource._sort<T>(getField, ascending);
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
          showCheckboxColumn: false,
          dataRowHeight: 120,
          actions: <Widget>[],
          header: Row(
            children: [
              Text('生产单列表'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
            ],
          ),
          rowsPerPage: _productionDataSource.productions.length,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('生产单编号'),
                tooltip: '生产单编号',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Production d) => d.productionID.toString(),
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('生产任务列表'),
                tooltip: '生产任务列表',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Production d) => d.tasks[0].task.toString(),
                    columnIndex,
                    ascending)),
          ],
          source: _productionDataSource,
        ),
      ],
    );
  }
}

class ScheduleDetailProductionResourceTable extends StatefulWidget {
  @override
  _ScheduleDetailProductionResourceTableState createState() =>
      _ScheduleDetailProductionResourceTableState();
}

class _ScheduleDetailProductionResourceTableState
    extends State<ScheduleDetailProductionResourceTable> {
  int _sortColumnIndex;
  bool _sortAscending = true;

  final _productionResourceDataSource =
      ProductionResourceDataSource(productionResources);

  void _sort<T>(Comparable<T> getField(ProductionResource d), int columnIndex,
      bool ascending) {
    _productionResourceDataSource._sort<T>(getField, ascending);
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
          showCheckboxColumn: false,
          dataRowHeight: 120,
          actions: <Widget>[],
          header: Row(
            children: [
              Text('生产单-资源关系表'),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
            ],
          ),
          rowsPerPage: _productionResourceDataSource.productionResources.length,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: <DataColumn>[
            DataColumn(
                label: const Text('生产单编号'),
                tooltip: '生产单编号',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (ProductionResource d) => d.productionID,
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('资源列表'),
                tooltip: '生产单使用的资源',
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (ProductionResource d) => d.resources[0].resourceID,
                    columnIndex,
                    ascending)),
          ],
          source: _productionResourceDataSource,
        ),
      ],
    );
  }
}

////////////////////////// DataSource ///////////////////////////////

class OrderPlanDataSource extends DataTableSource {
  OrderPlanDataSource(this.orderPlans);

  List<OrderPlan> orderPlans;

  void _sort<T>(Comparable<T> getField(OrderPlan d), bool ascending) {
    orderPlans.sort((OrderPlan a, OrderPlan b) {
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
    if (index >= orderPlans.length) return null;
    final OrderPlan orderPlan = orderPlans[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${orderPlan.orderId}')),
        DataCell(Text('${orderPlan.productNum}')),
        DataCell(
          Row(
            children: [
              ...orderPlan.schedules.map(
                (e) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                  child: Column(
                    children: [
                      Text('子订单  ：${e.id}'),
                      Text('产品数量：${e.productNum}'),
                      Text('开始时间：${dateTimeString(e.startTime)}'),
                      Text('结束时间：${dateTimeString(e.endTime)}'),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orderPlans.length;

  @override
  int get selectedRowCount => 0;
}

class OrderProductionDataSource extends DataTableSource {
  OrderProductionDataSource(this.orderProductions);

  List<OrderProduction> orderProductions;

  void _sort<T>(Comparable<T> getField(OrderProduction d), bool ascending) {
    orderProductions.sort((OrderProduction a, OrderProduction b) {
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
    if (index >= orderProductions.length) return null;
    final OrderProduction orderProduction = orderProductions[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${orderProduction.orderID}')),
        DataCell(Text('${orderProduction.productionID}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orderProductions.length;

  @override
  int get selectedRowCount => 0;
}

class ProductionDataSource extends DataTableSource {
  ProductionDataSource(this.productions);

  List<Production> productions;

  void _sort<T>(Comparable<T> getField(Production d), bool ascending) {
    productions.sort((Production a, Production b) {
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
    if (index >= productions.length) return null;
    final Production production = productions[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${production.id}')),
        DataCell(
          Row(
            children: [
              ...production.tasks.map(
                (e) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                  child: Column(
                    children: [
                      Text('生产编号：${e.id}'),
                      Text('产品编号：${e.task}'),
                      Text('开始时间：${dateTimeString(e.startTime)}'),
                      Text('结束时间：${dateTimeString(e.endTime)}'),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => productions.length;

  @override
  int get selectedRowCount => 0;
}

class ProductionResourceDataSource extends DataTableSource {
  ProductionResourceDataSource(this.productionResources);

  List<ProductionResource> productionResources;

  void _sort<T>(Comparable<T> getField(ProductionResource d), bool ascending) {
    productionResources.sort((ProductionResource a, ProductionResource b) {
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
    if (index >= productionResources.length) return null;
    final ProductionResource productionResource = productionResources[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${productionResource.productionID}')),
        DataCell(
          Row(
            children: [
              ...productionResource.resources.map(
                (e) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                  child: Column(
                    children: [
                      Text('资源编号：${e.resourceID}'),
                      Text('资源类型：${e.resourceType == 0 ? '人力资源' : '设备资源'}'),
                      Text('资源数量：${e.resourceNum}'),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => productionResources.length;

  @override
  int get selectedRowCount => 0;
}
