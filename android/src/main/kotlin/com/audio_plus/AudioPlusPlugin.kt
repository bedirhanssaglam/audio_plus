package com.audio_plus

import android.media.MediaPlayer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class AudioPlusPlugin : FlutterPlugin, MethodCallHandler {
    lateinit var channel: MethodChannel

    // Not private due to tests
    var mediaPlayer: MediaPlayer? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "audio_plus")
        channel.setMethodCallHandler(this)
        mediaPlayer = MediaPlayer()
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            Methods.PLAY -> {
                val filePath: String? = call.argument<String>("filePath")
                if (!filePath.isNullOrEmpty()) {
                    mediaPlayer?.apply {
                        reset()
                        setDataSource(filePath)
                        prepare()
                        start()
                    }
                    result.success("File played successfully")
                } else {
                    result.error("INVALID_ARGUMENT", "File path cannot be empty", null)
                }
            }

            Methods.PAUSE -> {
                mediaPlayer?.pause()
                result.success("File paused")
            }

            Methods.RESUME -> {
                val length: Int = mediaPlayer?.currentPosition ?: 0
                mediaPlayer?.seekTo(length)
                mediaPlayer?.start()
                result.success("File resumed")
            }

            Methods.STOP -> {
                mediaPlayer?.stop()
                mediaPlayer?.reset()
                mediaPlayer?.release()
                mediaPlayer = MediaPlayer()
                result.success("File stopped")
            }

            Methods.INCREASE_VOLUME -> {
                val volume: Float? = call.argument<Double>("volume")?.toFloat()
                if (volume != null) {
                    mediaPlayer?.setVolume(volume, volume)
                    result.success("Volume increased successfully")
                } else {
                    result.error("INVALID_ARGUMENT", "Volume not specified", null)
                }
            }

            Methods.SEEK_TO -> {
                val position: Int? = call.argument<Int>("position")
                    println(position)
                if (position != null) {
                    mediaPlayer?.seekTo(position)
                    result.success("File position updated")
                } else {
                    result.error("INVALID_ARGUMENT", "Position not specified", null)
                }
            }

            Methods.IS_PLAYING -> {
                val isPlaying: Boolean = mediaPlayer?.isPlaying ?: false
                result.success(isPlaying)
            }

            Methods.CURRENT_POSITION -> {
                val currentPositionInMillis: Double =
                    mediaPlayer?.currentPosition?.toDouble() ?: 0.0
                val currentPositionInSeconds: Double = currentPositionInMillis / 1000
                result.success(currentPositionInSeconds)
            }

            Methods.GET_DURATION -> {
                val durationInMillis: Double = mediaPlayer?.duration?.toDouble() ?: 0.0
                val durationInSeconds: Double = durationInMillis / 1000
                result.success(durationInSeconds)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        mediaPlayer?.release()
        mediaPlayer = null
    }
}
