#!/bin/bash

# Debug Build Variables Script
# This script will help us understand what the build variables are set to

set -e
set -u
set -o pipefail

echo "=== Debug Build Variables ==="

# Create a simple script that will be run during the build to show variables
cat > /workspace/ios/debug_variables.sh << 'EOF'
#!/bin/bash
echo "=== Build Variables Debug ==="
echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"
echo "PROJECT_DIR: ${PROJECT_DIR}"
echo "PWD: $(pwd)"
echo "=== End Build Variables Debug ==="
EOF

chmod +x /workspace/ios/debug_variables.sh

echo "Created debug script at /workspace/ios/debug_variables.sh"
echo "This script can be run during the build to see what variables are set to."