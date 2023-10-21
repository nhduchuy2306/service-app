import 'package:flutter/material.dart';

class ServiceCardWidget extends StatelessWidget {
  final String serviceName;
  final IconData icon;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const ServiceCardWidget({
    super.key,
    required this.serviceName,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: iconColor ?? Colors.black,
              ),
              const SizedBox(height: 7.0),
              Text(
                serviceName,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: textColor ?? Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
