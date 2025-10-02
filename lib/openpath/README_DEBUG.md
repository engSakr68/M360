# OpenPath SDK Debug Tools

This document explains how to use the comprehensive debugging tools I've added to help you verify if the OpenPath SDK is working properly.

## 🔧 New Debug Tools Added

### 1. OpenpathDebugService
**Location**: `lib/openpath/openpath_debug_service.dart`

A comprehensive service that provides:
- **Detailed Status Checks**: Get complete SDK status information
- **Automated Testing**: Run 6 different tests to verify SDK functionality
- **Continuous Monitoring**: Monitor SDK status in real-time
- **Report Generation**: Generate detailed reports for troubleshooting

### 2. OpenpathDebugScreen
**Location**: `lib/openpath/openpath_debug_screen.dart`

A user-friendly debug interface that provides:
- **Visual Health Score**: See SDK health at a glance (0-100%)
- **Permission Status**: Real-time permission monitoring
- **Service Status**: Check if OpenPath service is running and bound
- **Test Results**: Visual display of all test results
- **Live Logs**: Real-time debug logging
- **Continuous Monitoring**: 30-second interval status updates

### 3. Enhanced Native Methods
**Location**: `android/app/src/main/kotlin/com/PayChoice/Member360/OpenpathPlugin.kt`

Added new native methods:
- `getServiceStatus`: Check service binding and running status
- `getSDKVersion`: Get SDK version and available methods
- `getBluetoothStatus`: Detailed Bluetooth adapter information
- `getLocationStatus`: Location services and permissions status
- `testBluetoothScanning`: Test Bluetooth scanning capability
- `triggerTestEvent`: Test event stream functionality

## 🚀 How to Use

### Access the Debug Screen
1. Navigate to the OpenPath page in your app
2. Click the **"Debug SDK"** button at the bottom
3. The debug screen will open with comprehensive SDK information

### Understanding the Debug Screen

#### Health Score Card
- **Green (80-100%)**: SDK is healthy and working properly
- **Orange (60-79%)**: SDK has some issues but may still work
- **Red (0-59%)**: SDK has critical issues and likely won't work

#### Control Buttons
- **Refresh Status**: Update all SDK status information
- **Run Tests**: Execute comprehensive SDK functionality tests
- **Generate Report**: Create a detailed text report for troubleshooting
- **Start/Stop Monitor**: Enable continuous monitoring (updates every 30 seconds)

#### Status Cards
- **Permissions**: Shows Bluetooth, Location, and Notification permissions
- **Service Status**: Shows if the OpenPath service is running and bound
- **Test Results**: Visual display of all automated test results

#### Debug Logs
- Real-time logging of all debug operations
- Timestamps for easy tracking
- Clear button to reset logs

## 🔍 Automated Tests Explained

The debug service runs 6 comprehensive tests:

1. **Permission Test**: Verifies all required permissions are granted
2. **Initialization Test**: Checks if SDK can be initialized properly
3. **Method Availability Test**: Ensures all required SDK methods exist
4. **Service Binding Test**: Verifies the OpenPath service is bound correctly
5. **Bluetooth Scan Test**: Tests Bluetooth scanning capability
6. **Event Stream Test**: Checks if SDK events are working

## 📊 Interpreting Results

### Based on your original logs, here's what to expect:

#### ✅ What Should Work:
- Permission Test: PASSED (all permissions granted)
- Initialization Test: PASSED (service starts successfully)
- Method Availability Test: PASSED (all methods available)

#### ⚠️ Potential Issues:
- Service Binding Test: May FAIL (service instance null issue from logs)
- Bluetooth Scan Test: Should PASS (Bluetooth is working)
- Event Stream Test: May have issues

### Health Score Interpretation:
- **83-100%**: SDK is working properly, door access should work
- **67-83%**: SDK has minor issues but may still function
- **50-67%**: SDK has significant issues, door access uncertain
- **Below 50%**: SDK likely not functional

## 🛠️ Troubleshooting Guide

### If Health Score is Low:

1. **Service Binding Issues** (Most likely based on your logs):
   - Restart the app completely
   - Check if the OpenPath service is running in Android settings
   - Try unprovisioning and re-provisioning

2. **Permission Issues**:
   - Use the "Request Permissions" button in the debug screen
   - Manually check Android settings for Bluetooth and Location permissions

3. **SDK Version Issues**:
   - Check the SDK Version information in the debug screen
   - Ensure you're using OpenPath SDK v0.5.0 as indicated in your README

## 🔄 Continuous Monitoring

Enable continuous monitoring to:
- Track SDK status changes over time
- Monitor service stability
- Detect permission changes
- Log background behavior

## 📋 Generating Reports

Use the "Generate Report" button to create a comprehensive report including:
- Complete SDK status
- All test results
- Detailed recommendations
- Troubleshooting steps

This report can be shared with OpenPath support or used for debugging.

## 🎯 Next Steps

1. **Run the debug tools** to get your current SDK health score
2. **Address any failing tests** based on the recommendations
3. **Test actual door access** if health score is above 80%
4. **Use continuous monitoring** to track stability over time

The debug tools will give you definitive answers about whether your OpenPath SDK integration is working properly!