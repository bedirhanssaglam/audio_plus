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
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, AudioPlusConstants.CHANNEL_NAME)
        channel.setMethodCallHandler(this)
        mediaPlayer = MediaPlayer()
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            AudioPlusConstants.PLAY -> {
                val filePath: String? = call.argument<String>("filePath")
                if (!filePath.isNullOrEmpty()) {
                    mediaPlayer?.apply {
                        reset()
                        setDataSource(filePath)
                        prepare()
                        start()
                    }
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "File path cannot be empty", null)
                }
            }

            AudioPlusConstants.PLAY_URL -> {
                val url: String? = call.argument<String>("url")
                if (!url.isNullOrEmpty()) {
                    mediaPlayer?.apply {
                        reset()
                        setDataSource(url)
                        prepare()
                        start()
                    }
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "URL cannot be empty", null)
                }
            }

            AudioPlusConstants.PAUSE -> {
                mediaPlayer?.pause()
                result.success(null)
            }

            AudioPlusConstants.RESUME -> {
                val length: Int = mediaPlayer?.currentPosition ?: 0
                mediaPlayer?.seekTo(length)
                mediaPlayer?.start()
                result.success(null)
            }

            AudioPlusConstants.STOP -> {
                mediaPlayer?.apply {
                    stop()
                    reset()
                    release()
                }
                mediaPlayer = MediaPlayer()
                result.success(null)
            }

            AudioPlusConstants.INCREASE_VOLUME -> {
                val volume: Float? = call.argument<Double>("volume")?.toFloat()
                if (mediaPlayer != null) {
                    if (volume != null) {
                        mediaPlayer?.setVolume(volume, volume)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENT", "Volume not specified", null)
                    }
                } else {
                    result.success(null)
                }
            }

            AudioPlusConstants.SEEK_TO -> {
                val position: Int? = call.argument<Int>("position")
                println(position)
                if (position != null) {
                    mediaPlayer?.seekTo(position)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "Position not specified", null)
                }
            }

            AudioPlusConstants.IS_PLAYING -> {
                val isPlaying: Boolean = mediaPlayer?.isPlaying ?: false
                result.success(isPlaying)
            }

            AudioPlusConstants.CURRENT_POSITION -> {
                val currentPositionInMillis: Double =
                    mediaPlayer?.currentPosition?.toDouble() ?: 0.0
                val currentPositionInSeconds: Double = currentPositionInMillis / 1000
                result.success(currentPositionInSeconds)
            }

            AudioPlusConstants.GET_DURATION -> {
                val durationInMillis: Double = mediaPlayer?.duration?.toDouble() ?: 0.0
                val durationInSeconds: Double = durationInMillis / 1000
                result.success(durationInSeconds)
            }

            AudioPlusConstants.IS_LOOPING -> {
                val isReplay: Boolean = call.argument<Boolean?>("isLooping") ?: false
                mediaPlayer?.isLooping = isReplay
                if (isReplay) {
                    mediaPlayer?.setOnCompletionListener { it.start() }
                } else {
                    mediaPlayer?.setOnCompletionListener(null)
                }
                result.success(null)
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
