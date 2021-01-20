/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import 'dart:convert';
import 'dart:core';
import 'dart:core' as core;
import 'dart:typed_data';

import 'package:ews/Enumerations/Enumerations.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/TypedPropertyDefinition.dart';

/// <summary>
/// Represents byte array property definition.
/// </summary>
class ByteArrayPropertyDefinition extends TypedPropertyDefinition {
  /// <summary>
  /// Initializes a new instance of the <see cref="ByteArrayPropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  ByteArrayPropertyDefinition(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {}

  /// <summary>
  /// Parses the specified value.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>Byte array value.</returns>
  @override
  Object Parse(String? value) {
    return base64.decode(value!);
  }

  /// <summary>
  /// Converts byte array property to a string.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>Byte array value.</returns>
//  @override
//  String toString(Object value) {
//    return Convert.ToBase64String((Uint8List)value);
//  }

  /// <summary>
  /// Gets a value indicating whether this property definition is for a nullable type (ref, int?, bool?...).
  /// </summary>
  @override
  bool get IsNullable => true;

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type => Uint8List;
}
