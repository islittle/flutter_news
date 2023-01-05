import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

router(BuildContext context) {
  AutoRouter.of(context);
  return context.router;
}
