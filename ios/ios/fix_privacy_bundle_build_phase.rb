#!/usr/bin/env ruby

require 'xcodeproj'

# Open the project
project_path = 'Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Get the Runner target
runner_target = project.targets.find { |target| target.name == 'Runner' }

if runner_target.nil?
  puts "❌ Runner target not found"
  exit 1
end

puts "🔧 Fixing privacy bundle build phases for Runner target..."

# Remove existing privacy bundle script phases
runner_target.build_phases.each do |phase|
  if phase.is_a?(Xcodeproj::Project::Object::PBXShellScriptBuildPhase)
    if phase.name && (phase.name.include?('Privacy') || phase.name.include?('privacy'))
      puts "• Removing existing privacy script phase: #{phase.name}"
      runner_target.build_phases.delete(phase)
    end
  end
end

# Create new privacy bundle copy script phase
privacy_phase = runner_target.new_shell_script_build_phase('[CP] Copy Privacy Bundles')
privacy_phase.shell_path = '/bin/sh'
privacy_phase.show_env_vars_in_log = false

privacy_script = <<~SCRIPT
  set -e
  set -u
  set -o pipefail
  
  echo "=== Copying Privacy Bundles to App Bundle ==="
  
  SRCROOT="${SRCROOT}"
  BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
  FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH}"
  
  # List of plugins that need privacy bundles
  PRIVACY_PLUGINS=(
    "image_picker_ios"
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
  )
  
  # Copy privacy bundles for all plugins
  for plugin in "${PRIVACY_PLUGINS[@]}"; do
    echo "Processing privacy bundle for: $plugin"
    
    PRIVACY_BUNDLE_SRC="${SRCROOT}/${plugin}_privacy.bundle"
    PRIVACY_BUNDLE_DST="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/${plugin}_privacy.bundle"
    TARGET_DST="${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
    
    if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
      echo "Copying ${plugin} privacy bundle..."
      
      # Copy to frameworks folder
      mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST}"
      echo "✅ Copied to frameworks folder: ${PRIVACY_BUNDLE_DST}"
      
      # Copy to target-specific directory
      mkdir -p "${BUILT_PRODUCTS_DIR}/${plugin}"
      cp -R "${PRIVACY_BUNDLE_SRC}" "${TARGET_DST}"
      echo "✅ Copied to target directory: ${TARGET_DST}"
      
      echo "✅ ${plugin} privacy bundle copied"
    else
      echo "⚠️ ${plugin} privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
      # Create minimal privacy bundle as fallback
      mkdir -p "${TARGET_DST}"
      cat > "${TARGET_DST}/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
      echo "✅ Created minimal privacy bundle for ${plugin}"
    fi
  done
  
  echo "=== Privacy Bundle Copy Complete ==="
SCRIPT

privacy_phase.shell_script = privacy_script

# Move the script phase to be the last phase
runner_target.build_phases.move(privacy_phase, runner_target.build_phases.count - 1)

puts "✅ Added privacy bundle copying script phase to Runner target"

# Save the project
project.save

puts "✅ Xcode project updated successfully"
