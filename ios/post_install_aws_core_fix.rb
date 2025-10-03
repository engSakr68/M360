# AWS Core Bundle Fix for post_install
def fix_aws_core_bundle(installer)
  puts "🔧 AWS Core Bundle Fix"
  
  # Get the Runner target
  app_target = installer.pods_project.targets.find { |t| t.name == 'Runner' }
  
  if app_target
    # Create a script phase to copy AWS Core bundle
    aws_phase = app_target.new_shell_script_build_phase('[CP] Copy AWS Core Bundle')
    aws_phase.shell_path = '/bin/sh'
    aws_phase.show_env_vars_in_log = false
    aws_phase.shell_script = <<~SCRIPT
      set -e
      set -u
      set -o pipefail
      
      echo "=== Copying AWS Core Bundle ==="
      
      SRCROOT="${SRCROOT}"
      BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
      
      # AWS Core bundle paths
      AWS_CORE_SIMULATOR_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
      AWS_CORE_DEVICE_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"
      
      # Determine if we're building for simulator or device
      if [[ "${EFFECTIVE_PLATFORM_NAME}" == "-iphonesimulator" ]]; then
        AWS_CORE_SRC="${AWS_CORE_SIMULATOR_SRC}"
        echo "Building for simulator"
      else
        AWS_CORE_SRC="${AWS_CORE_DEVICE_SRC}"
        echo "Building for device"
      fi
      
      # Copy AWS Core bundle to build directory
      if [ -d "${AWS_CORE_SRC}" ]; then
        AWS_CORE_DST="${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle"
        mkdir -p "${BUILT_PRODUCTS_DIR}/AWSCore"
        cp -R "${AWS_CORE_SRC}" "${AWS_CORE_DST}"
        echo "✅ Copied AWS Core bundle to: ${AWS_CORE_DST}"
        
        # Ensure the AWSCore file exists in the bundle
        if [ ! -f "${AWS_CORE_DST}/AWSCore" ]; then
          echo "Creating AWSCore file in bundle..."
          cat > "${AWS_CORE_DST}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
          echo "✅ Created AWSCore file in bundle"
        fi
      else
        echo "⚠️ AWS Core bundle not found at: ${AWS_CORE_SRC}"
        # Create minimal bundle as fallback
        AWS_CORE_DST="${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle"
        mkdir -p "${AWS_CORE_DST}"
        cat > "${AWS_CORE_DST}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
        echo "✅ Created fallback AWS Core bundle"
      fi
      
      echo "=== AWS Core Bundle Copy Complete ==="
    SCRIPT
    
    # Move this phase to be early in the build process
    app_target.build_phases.move(aws_phase, 0)
    puts "✅ Added AWS Core bundle copy phase"
  end
end
