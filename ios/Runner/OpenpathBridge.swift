// ios/Runner/OpenpathBridge.swift
import Foundation
import Flutter
import OpenpathMobile
import UIKit

public class OpenpathBridge: NSObject, FlutterPlugin, FlutterStreamHandler, OpenpathMobileAccessCoreDelegate {

  // MARK: - Channels
  private static var methodChannel: FlutterMethodChannel!
  private static var eventChannel: FlutterEventChannel!
  private static var shared: OpenpathBridge?   // keep strong ref

  private var eventSink: FlutterEventSink?

  // MARK: - SDK
  let core = OpenpathMobileAccessCore.shared

  // Keep a tiny in-memory snapshot of items as the SDK streams them in.
  private var items: [String: Any] = [:]

  // MARK: - Register
  public static func register(with registrar: FlutterPluginRegistrar) {
    methodChannel = FlutterMethodChannel(name: "openpath", binaryMessenger: registrar.messenger())
    let instance = OpenpathBridge()
    shared = instance
    registrar.addMethodCallDelegate(instance, channel: methodChannel)

    eventChannel = FlutterEventChannel(name: "openpath_events", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)

    // Set delegate early so we get SDK events even before the first Dart call
    instance.core.delegate = instance
  }

  deinit {
    if core.delegate === self {
      core.delegate = nil
    }
  }

  // MARK: - Stream handler
  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    // If we already have a snapshot, push it immediately so UI can render
    if !items.isEmpty {
      emit("items_set", items)
    }
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }

  // MARK: - Flutter methods
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // Ensure we have the delegate (harmless if set multiple times)
    core.delegate = self

    switch call.method {

    case "provision":
      guard let args = call.arguments as? [String: Any] else {
        return result(FlutterError(code: "bad_args", message: "Missing args", details: nil))
      }

      // Accept either 'token' or legacy 'jwt' key from the Flutter side.
      let token = (args["token"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        ?? (args["jwt"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)

      guard let setupToken = token, !setupToken.isEmpty else {
        return result(FlutterError(code: "bad_args", message: "Missing token/jwt", details: nil))
      }

      core.provision(setupMobileToken: setupToken)
      result(true)

    case "unprovision":
      let userOpal = (call.arguments as? [String: Any])?["userOpal"] as? String
      core.unprovision(userOpal: userOpal)
      result(nil)

    case "unlock":
      guard
        let args = call.arguments as? [String: Any],
        let itemType = args["itemType"] as? String,
        let itemIdAny = args["itemId"]
      else { return result(FlutterError(code: "bad_args", message: "Missing itemType/itemId", details: nil)) }

      guard let itemId = Self.coerceInt(itemIdAny) else {
        return result(FlutterError(code: "bad_args", message: "itemId must be an integer", details: nil))
      }

      // requestId is useful to correlate responses; generate if not supplied.
      let requestId = Self.coerceInt((args["requestId"] ?? Int.random(in: 100_000...999_999))) ?? Int.random(in: 100_000...999_999)
      let timeout   = Self.coerceInt(args["timeoutMs"]) ?? 8000

      core.unlock(itemType: itemType, itemId: itemId, requestId: requestId, timeout: timeout)
      result(requestId) // return the id so Dart can correlate

    case "getAuthorizationStatuses":
      let dict = core.getAuthorizationStatuses() // [String: Any] JSON-safe
      result(dict)

    case "requestAuthorization":
      guard
        let args = call.arguments as? [String: Any],
        let authType = args["authType"] as? String, !authType.isEmpty
      else { return result(FlutterError(code: "bad_args", message: "Missing authType", details: nil)) }

      core.requestAuthorization(authType)
      result(nil)

    case "softRefresh":
      core.softRefresh()
      result(nil)

    case "getItemsSnapshot":
      result(items)

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  // MARK: - Emit helper
  private func emit(_ name: String, _ payload: Any?) {
    guard let sink = eventSink else { return }
    var envelope: [String: Any] = ["event": name]
    if let payload = payload { envelope["data"] = payload }
    // Push on main to avoid threading warnings
    DispatchQueue.main.async {
      sink(envelope)
    }
  }

  // MARK: - OpenpathMobileAccessCoreDelegate (events from SDK)

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onItemsSet message: [String : Any]) {
    items = message
    emit("items_set", message)
  }

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onItemsUpdated message: [String : Any]) {
    emit("items_updated", message)
  }

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onItemStatesUpdated message: [String : Any]) {
    emit("item_states_updated", message)
  }

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onUnlockResponse message: [String : Any]) {
    emit("unlock_response", message)
  }

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onProvisionResponse message: [String : Any]) {
    emit("provision_response", message)
  }

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onUnprovisionResponse message: [String : Any]) {
    emit("unprovision_response", message)
  }

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onBluetoothStatusChanged message: [String : Any]) {
    emit("bluetooth_status", message)
  }

  public func openpathMobileAccessCore(_ core: OpenpathMobileAccessCore, onInternetStatusChanged isOnline: Bool) {
    emit("internet_status", ["online": isOnline])
  }

  // MARK: - Helpers
  private static func coerceInt(_ any: Any?) -> Int? {
    switch any {
      case let i as Int: return i
      case let n as NSNumber: return n.intValue
      case let d as Double: return Int(d)
      case let s as String: return Int(s)
      default: return nil
    }
  }
}
