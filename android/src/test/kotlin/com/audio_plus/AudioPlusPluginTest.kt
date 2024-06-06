package com.audio_plus

import android.media.MediaPlayer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import org.mockito.Mockito
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import kotlin.test.BeforeTest

/*
 * This demonstrates a simple unit test of the Kotlin portion of this plugin's implementation.
 *
 * Once you have built the plugin's example app, you can run these tests from the command
 * line by running `./gradlew testDebugUnitTest` in the `example/android/` directory, or
 * you can run them directly from IDEs that support JUnit such as Android Studio.
 */

internal class AudioPlusPluginTest {
    @Mock
    lateinit var mockMediaPlayer: MediaPlayer

    @Mock
    lateinit var mockMethodChannel: MethodChannel

    private lateinit var audioPlusPlugin: AudioPlusPlugin

    @BeforeTest
    fun setUp() {
        MockitoAnnotations.openMocks(this)
        audioPlusPlugin = AudioPlusPlugin()
        audioPlusPlugin.mediaPlayer = mockMediaPlayer
        audioPlusPlugin.channel = mockMethodChannel
    }

    @Test
    fun onMethodCall_play_returnsSuccess() {
        val filePath = "sample/file/path.mp3"
        val methodCall = MethodCall(Methods.PLAY, mapOf("filePath" to filePath))
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockMediaPlayer).reset()
        Mockito.verify(mockMediaPlayer).setDataSource(filePath)
        Mockito.verify(mockMediaPlayer).prepare()
        Mockito.verify(mockMediaPlayer).start()
        Mockito.verify(mockResult).success("File played successfully")
    }

    @Test
    fun onMethodCall_pause_returnsSuccess() {
        val methodCall = MethodCall(Methods.PAUSE, null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockMediaPlayer).pause()
        Mockito.verify(mockResult).success("File paused")
    }

    @Test
    fun onMethodCall_resume_returnsSuccess() {
        val methodCall = MethodCall(Methods.RESUME, null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        Mockito.`when`(mockMediaPlayer.currentPosition).thenReturn(0)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockMediaPlayer).seekTo(0)
        Mockito.verify(mockMediaPlayer).start()
        Mockito.verify(mockResult).success("File resumed")
    }

    @Test
    fun onMethodCall_stop_returnsSuccess() {
        val methodCall = MethodCall(Methods.STOP, null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockMediaPlayer).stop()
        Mockito.verify(mockMediaPlayer).release()
        Mockito.verify(mockResult).success("File stopped")
    }

    @Test
    fun onMethodCall_increaseVolume_returnsSuccess() {
        val methodCall = MethodCall(Methods.INCREASE_VOLUME, mapOf("volume" to 0.5))
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockMediaPlayer).setVolume(0.5f, 0.5f)
        Mockito.verify(mockResult).success("Volume increased successfully")
    }

    @Test
    fun onMethodCall_seekTo_returnsSuccess() {
        val methodCall = MethodCall(Methods.SEEK_TO, mapOf("position" to 1000))
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockMediaPlayer).seekTo(1000)
        Mockito.verify(mockResult).success("File position updated")
    }

    @Test
    fun onMethodCall_isPlaying_returnsSuccess() {
        val methodCall = MethodCall(Methods.IS_PLAYING, null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        Mockito.`when`(mockMediaPlayer.isPlaying).thenReturn(true)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockResult).success(true)
    }

    @Test
    fun onMethodCall_currentPosition_returnsSuccess() {
        val methodCall = MethodCall(Methods.CURRENT_POSITION, null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        Mockito.`when`(mockMediaPlayer.currentPosition).thenReturn(2000)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockResult).success(2.0)
    }

    @Test

    fun onMethodCall_getDuration_returnsSuccess() {
        val methodCall = MethodCall(Methods.GET_DURATION, null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        Mockito.`when`(mockMediaPlayer.duration)
            .thenReturn(2000)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockResult).success(2.0)
    }


    @Test
    fun onMethodCall_invalidMethod_returnsNotImplemented() {
        val methodCall = MethodCall("invalidMethod", null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

        audioPlusPlugin.onMethodCall(methodCall, mockResult)

        Mockito.verify(mockResult).notImplemented()
    }
}
