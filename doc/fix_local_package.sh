#!/bin/bash

echo "🔧 Fixing local package dependencies..."

# Fix flowy_infra
cat > packages/flowy_infra/pubspec.yaml << 'EOF'
name: flowy_infra
description: AppFlowy Infra.
version: 0.0.1
homepage: https://appflowy.io

environment:
  sdk: ">=3.3.0 <4.0.0"
  flutter: ">=3.10.1"

dependencies:
  flutter:
    sdk: flutter
  json_annotation: ^4.8.1
  path_provider: ^2.0.15
  path: ^1.8.3
  time: ^2.1.3
  uuid: ^4.4.0
  bloc: ^9.1.0
  freezed_annotation: ^3.1.0
  file_picker: ^8.1.4
  file: ^7.0.0

dev_dependencies:
  build_runner: ^2.10.2
  flutter_lints: ^6.0.0
  freezed: ^2.4.4
  json_serializable: ^6.9.0
EOF

# Fix flowy_infra_ui
cat > packages/flowy_infra_ui/pubspec.yaml << 'EOF'
name: flowy_infra_ui
description: A new flutter plugin project.
version: 0.0.1
homepage: https://appflowy.io
publish_to: "none"

environment:
  sdk: ">=3.3.0 <4.0.0"
  flutter: ">=3.10.1"

dependencies:
  flutter:
    sdk: flutter

  # Thirdparty packages
  styled_widget: ^0.4.1
  animations: ^2.0.7
  loading_indicator: ^3.1.0
  async: ^2.11.0
  url_launcher: ^6.1.11
  google_fonts: ^6.1.0

  # Federated Platform Interface
  flowy_infra_ui_platform_interface:
    path: flowy_infra_ui_platform_interface
  appflowy_popover:
    path: ../appflowy_popover
  flowy_infra:
    path: ../flowy_infra
  flowy_svg:
    path: ../flowy_svg

dev_dependencies:
  build_runner: ^2.10.2
  provider: ^6.0.5
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  plugin:
    platforms:
      ios:
        pluginClass: FlowyInfraUIPlugin
      macos:
        pluginClass: FlowyInfraUIPlugin
      windows:
        pluginClass: FlowyInfraUIPlugin
      linux:
        pluginClass: FlowyInfraUIPlugin
      web:
        default_package: flowy_infra_ui_web
EOF

# Fix appflowy_popover
cat > packages/appflowy_popover/pubspec.yaml << 'EOF'
name: appflowy_popover
description: A new Flutter package project.
version: 0.0.1
homepage: https://appflowy.io

environment:
  flutter: ">=3.22.0"
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
EOF

# Fix appflowy_result
cat > packages/appflowy_result/pubspec.yaml << 'EOF'
name: appflowy_result
description: "A new Flutter package project."
version: 0.0.1
homepage: https://github.com/appflowy-io/appflowy

environment:
  sdk: ">=3.3.0 <4.0.0"
  flutter: ">=1.17.0"

dev_dependencies:
  flutter_lints: ^6.0.0
EOF

# Fix appflowy_ui
cat > packages/appflowy_ui/pubspec.yaml << 'EOF'
name: appflowy_ui
description: "A Flutter package for AppFlowy UI components and widgets"
version: 1.0.0
homepage: https://github.com/appflowy-io/appflowy

environment:
  sdk: ">=3.3.0 <4.0.0"
  flutter: ">=1.17.0"

dependencies:
  cached_network_image: ^3.4.1
  flutter:
    sdk: flutter
  flutter_animate: ^4.5.2
  flutter_lints: ^6.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
EOF

# Fix appflowy_backend
cat > packages/appflowy_backend/pubspec.yaml << 'EOF'
name: appflowy_backend
description: A new flutter plugin project.
version: 0.0.1
homepage: https://appflowy.io
publish_to: "none"

environment:
  sdk: ">=3.3.0 <4.0.0"
  flutter: ">=1.17.0"

dependencies:
  flutter:
    sdk: flutter
  ffi: ^2.0.2
  isolates: ^3.0.3+8
  protobuf: ^3.1.0
  talker: ^4.7.1
  plugin_platform_interface: ^2.1.3
  appflowy_result:
    path: ../appflowy_result
  fixnum: ^1.1.0
  async: ^2.11.0

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  plugin:
    platforms:
      android:
        package: com.plugin.appflowy_backend
        pluginClass: AppFlowyBackendPlugin
      ios:
        pluginClass: AppFlowyBackendPlugin
      macos:
        pluginClass: AppFlowyBackendPlugin
      windows:
        pluginClass: AppFlowyBackendPlugin
EOF

echo "✅ Local packages fixed!"
echo ""
echo "Now run:"
echo "  flutter pub get"