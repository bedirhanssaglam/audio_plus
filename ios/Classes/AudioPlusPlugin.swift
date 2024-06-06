import Flutter
import UIKit
import AVFoundation

/// A Flutter plugin for playing audio files using the AVFoundation framework on iOS.
public class AudioPlusPlugin: NSObject, FlutterPlugin {
    private var channel: FlutterMethodChannel?
    private var audioPlayer: AVAudioPlayer?
    private var currentPosition: TimeInterval = 0

    /// Enum to represent method names used in method channel communication.
    private enum MethodName: String {
        case play
        case pause
        case resume
        case stop
        case increaseVolume
        case seekTo
        case isPlaying
        case currentPosition
        case getDuration
    }

    /// Registers the plugin with the Flutter registrar and sets up method call delegation.
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "audio_plus", binaryMessenger: registrar.messenger())
        let instance = AudioPlusPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    /// Handles incoming method calls from the Flutter application.
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = MethodName(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }

        switch method {
        case .play:
            guard let arguments = call.arguments as? [String: Any],
                  let filePath = arguments["filePath"] as? String,
                  let url = URL(string: filePath) else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "File path not specified", details: nil))
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                result("File played successfully")
            } catch let error {
                result(FlutterError(code: "PLAYER_ERROR", message: "File playback error: \(error.localizedDescription)", details: nil))
            }
        case .pause:
            guard let player = audioPlayer else {
                result(FlutterError(code: "PLAYER_ERROR", message: "Player not initialized", details: nil))
                return
            }
            player.pause()
            currentPosition = player.currentTime
            result("File paused")
        case .resume:
            guard let player = audioPlayer else {
                result(FlutterError(code: "PLAYER_ERROR", message: "Player not initialized", details: nil))
                return
            }
            player.currentTime = currentPosition
            player.play()
            result("File resumed")
        case .stop:
            audioPlayer?.stop()
            audioPlayer = nil
            currentPosition = 0
            result("File stopped")
        case .increaseVolume:
            guard let player = audioPlayer,
                  let arguments = call.arguments as? [String: Any],
                  let volume = arguments["volume"] as? Double else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Volume not specified", details: nil))
                return
            }
            player.volume = Float(volume)
            result("Volume increased successfully")
        case .seekTo:
            guard let player = audioPlayer,
                  let arguments = call.arguments as? [String: Any],
                  let position = arguments["position"] as? Int else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Position not specified", details: nil))
                return
            }
            player.currentTime = TimeInterval(position)
            result("File position updated")
        case .isPlaying:
            let isPlaying = audioPlayer?.isPlaying ?? false
            result(isPlaying)
        case .currentPosition:
            result(audioPlayer?.currentTime ?? 0.0)
        case .getDuration:
            result(audioPlayer?.duration ?? 0.0)
        }
    }
}
