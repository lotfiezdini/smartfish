import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

enum UserType {
  @JsonValue("agent")
  agent,
  @JsonValue("officer")
  officer,
  @JsonValue("fisherman")
  fisherman,
}