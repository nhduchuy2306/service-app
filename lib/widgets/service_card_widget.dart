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
    return Container(
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: 100,
      height: 120,
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Icon(
              icon,
              size: 30,
              color: iconColor ?? Colors.black,
            ),
            const SizedBox(height: 10),
            Text(
              serviceName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: textColor ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
