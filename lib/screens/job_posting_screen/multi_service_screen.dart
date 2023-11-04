import 'package:flutter/material.dart';
import 'package:service_app/models/cart_model.dart';
import 'package:service_app/models/category.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/models/quantity_unit.dart';
import 'package:service_app/models/task_detail_model.dart';
import 'package:service_app/screens/job_posting_screen/quantity_time_screen.dart';

class MultiServiceScreen extends StatefulWidget {
  const MultiServiceScreen({
    super.key,
    required this.taskDetails,
    required this.category,
    required this.customer,
  });

  final List<TaskDetail>? taskDetails;
  final Category? category;
  final Customer? customer;

  @override
  State<MultiServiceScreen> createState() => _MultiServiceScreenState();
}

class _MultiServiceScreenState extends State<MultiServiceScreen> {
  List<int> selectedCheckboxIndices = [];
  Map<int, int> selectedExpansions = {};

  List<CartItems> mapToListCardItems() {
    List<CartItems> cartItems = [];
    if (selectedCheckboxIndices.isEmpty) {
      for (int i = 0; i < selectedExpansions.length; i++) {
        cartItems.add(
          CartItems(
            taskDetailId: selectedExpansions.keys.elementAt(i),
            quantity: selectedExpansions.values.elementAt(i),
            unit: QuantityEnum.Unit.index,
            price: widget.taskDetails?[i].price,
          ),
        );
      }
    } else {
      for (int i = 0; i < selectedCheckboxIndices.length; i++) {
        cartItems.add(
          CartItems(
            taskDetailId: selectedCheckboxIndices[i],
            quantity: widget.taskDetails?[i].quantity,
            unit: QuantityEnum.M2.index,
            price: widget.taskDetails?[i].price,
          ),
        );
      }
    }

    return cartItems;
  }

  List<TaskDetail> getChoosingTaskDetail() {
    List<TaskDetail> taskDetails = [];
    if (selectedCheckboxIndices.isEmpty) {
      selectedExpansions.forEach((key, value) {
        TaskDetail? taskDetail =
            widget.taskDetails?.firstWhere((element) => element.id == key);
        taskDetails.add(taskDetail!);
      });
    } else {
      for (int i = 0; i < selectedCheckboxIndices.length; i++) {
        TaskDetail? taskDetail =
            widget.taskDetails?.firstWhere((element) => element.id == selectedCheckboxIndices[i]);
        taskDetails.add(taskDetail!);
      }
    }
    return taskDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.category?.name ?? "Service"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.taskDetails?.length,
        itemBuilder: (context, index) {
          final taskDetail = widget.taskDetails?[index];
          if (taskDetail?.unit == QuantityEnum.M2.index) {
            // Render Checkbox for QuantityEnum.M2
            return CheckboxCard(
              taskDetail: taskDetail,
              isSelected: selectedCheckboxIndices
                  .contains(widget.taskDetails?[index].id),
              onSelectedChanged: (isSelected) {
                setState(() {
                  if (isSelected ?? false) {
                    selectedCheckboxIndices
                        .add(widget.taskDetails![index].id ?? 0);
                  } else {
                    selectedCheckboxIndices
                        .remove(widget.taskDetails?[index].id);
                  }
                });
              },
            );
          } else {
            // Render ExpansionTile for other QuantityEnums
            return ExpansionTileCard(
              taskDetail: taskDetail,
              selectedQuantity:
                  selectedExpansions[widget.taskDetails![index].id ?? 0] ?? 0,
              onQuantityChanged: (quantity) {
                setState(() {
                  selectedExpansions[widget.taskDetails![index].id ?? 0] =
                      quantity;
                });
              },
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: ElevatedButton(
          onPressed: () {
            if (mapToListCardItems().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select at least one service"),
                ),
              );
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuantityTimeScreen(
                  cartItems: mapToListCardItems(),
                  customer: widget.customer,
                  taskDetails: getChoosingTaskDetail(),
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CheckboxCard extends StatelessWidget {
  final TaskDetail? taskDetail;
  final bool isSelected;
  final ValueChanged<bool?> onSelectedChanged;

  const CheckboxCard({
    super.key,
    required this.taskDetail,
    required this.isSelected,
    required this.onSelectedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      borderOnForeground: false,
      child: CheckboxListTile(
        title: Text(
          taskDetail?.name ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              taskDetail?.description ?? "",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "${taskDetail?.price?.toStringAsFixed(0)} VND",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        value: isSelected,
        onChanged: onSelectedChanged,
      ),
    );
  }
}

class ExpansionTileCard extends StatelessWidget {
  final TaskDetail? taskDetail;
  final int selectedQuantity;
  final ValueChanged<int> onQuantityChanged;

  const ExpansionTileCard({
    super.key,
    required this.taskDetail,
    required this.selectedQuantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      borderOnForeground: false,
      child: ExpansionTile(
        title: Text(
          taskDetail?.name ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              taskDetail?.description ?? "",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "${taskDetail?.price?.toStringAsFixed(0)} VND / piece",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      // Minus button with blue color
                      onPressed: () {
                        if (selectedQuantity > 0) {
                          onQuantityChanged(selectedQuantity - 1);
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      selectedQuantity.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      // Plus button with blue color
                      onPressed: () => onQuantityChanged(selectedQuantity + 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
