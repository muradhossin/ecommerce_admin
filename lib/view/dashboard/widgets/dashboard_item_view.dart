import 'package:ecommerce_admin/view/dashboard/models/dashboard_model.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {
  final DashboardModel model;
  final Widget? badge;

  const DashboardItemView({super.key, required this.model, this.badge});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, model.routeName),
      child: Card(
        elevation: 2,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Icon(
                    model.iconData,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                  if(badge != null) badge!,
                ],
              ),
              const SizedBox(height: 10,),
              Text(
                model.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
