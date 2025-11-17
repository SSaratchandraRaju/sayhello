import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart' show Get, GetNavigation;
import '../services/agora_service.dart';

class CallView extends StatefulWidget {
  final AgoraService agoraService;
  final String channelName;
  final String? userName;

  const CallView({
    Key? key,
    required this.agoraService,
    required this.channelName,
    this.userName,
  }) : super(key: key);

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> with WidgetsBindingObserver {
  void _log(String msg) => print('[CALL] $msg');

  bool _isAudioEnabled = true;
  bool _isVideoEnabled = true;
  bool _isCallConnected = false;
  int? _remoteUid;
  Timer? _remotePollTimer;
  VideoViewController? _localController;
  VideoViewController? _remoteController;
  bool _isVideoSwapped = false; // Track if videos are swapped

  @override
  void initState() {
    super.initState();
    // Add lifecycle observer to handle app state changes (for PIP)
    WidgetsBinding.instance.addObserver(this);

    // Delay heavy plugin/native initialization until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _log('App lifecycle state changed to: $state');

    // Handle PIP mode when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // Only enter PIP if we're actually in a call
      if (_isCallConnected && _remoteUid != null) {
        _log('App paused/inactive with active call - entering PIP mode');
        _enterPipMode();
      }
    } else if (state == AppLifecycleState.resumed) {
      _log('App resumed from background');
    }
  }

  // Enter Picture-in-Picture mode
  Future<void> _enterPipMode() async {
    try {
      const platform = MethodChannel('com.sayhello/pip');
      final result = await platform.invokeMethod('enterPipMode');
      _log('PIP mode result: $result');
    } catch (e) {
      _log('Error entering PIP mode: $e');
    }
  }

  Future<void> _initialize() async {
    _log('Initializing Agora call screen for ${widget.channelName}');

    // Initialize Agora engine and join the channel when the call screen is shown.
    try {
      await widget.agoraService.initialize();

      // Setup callback for when all users leave
      widget.agoraService.onAllUsersLeft = () {
        _log('All remote users left, ending call automatically');
        _showRemoteUserLeftDialog();
      };

      // Setup local video controller before joining
      _localController = VideoViewController(
        rtcEngine: widget.agoraService.engine,
        canvas: const VideoCanvas(uid: 0),
      );

      await widget.agoraService.joinChannel(widget.channelName);
    } catch (e) {
      _log('Agora initialization/join failed: $e');
    }

    // Start polling for remote UID (simple approach for this migration)
    _remotePollTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      final ruid = widget.agoraService.remoteUid;
      if (ruid != null && ruid != _remoteUid) {
        setState(() {
          _remoteUid = ruid;
          _isCallConnected = true;
          _remoteController = VideoViewController.remote(
            rtcEngine: widget.agoraService.engine,
            canvas: VideoCanvas(
              uid: ruid,
              renderMode: RenderModeType.renderModeHidden,
            ),
            connection: RtcConnection(channelId: widget.channelName),
          );
        });
        _log('Detected remote uid: $ruid');
      }
    });

    // Agora handles events via AgoraService and logs them. Remote uid polling above
    // will update the UI once a remote user joins.
  }

  // Call rejection dialog removed (handled by AgoraService/logs).

  void _toggleAudio() {
    widget.agoraService.toggleAudio();
    setState(() {
      _isAudioEnabled = !_isAudioEnabled;
    });
    _log('Audio ${_isAudioEnabled ? "enabled" : "muted"}');
  }

  void _toggleVideo() {
    widget.agoraService.toggleVideo();
    setState(() {
      _isVideoEnabled = !_isVideoEnabled;
    });
    _log('Video ${_isVideoEnabled ? "enabled" : "disabled"}');
  }

  Future<void> _switchCamera() async {
    _log('Switching camera');
    await widget.agoraService.switchCamera();
  }

  void _showRemoteUserLeftDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Call Ended'),
        content: const Text('The other user has left the call.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _endCall();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _endCall() async {
    _log('Ending call');
    if (!mounted) return;

    try {
      await widget.agoraService.leaveChannel();
    } catch (e) {
      _log('Error leaving Agora channel: $e');
    }

    _remotePollTimer?.cancel();

    // Navigate back to home screen (not just pop)
    if (mounted) {
      // Use GetX to navigate back to home, clearing call screen from stack
      Get.offAllNamed('/users', arguments: {'userName': widget.userName});
    }
  }

  Future<bool> _onWillPop() async {
    // Show confirmation dialog before leaving call
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Call?'),
        content: const Text('Are you sure you want to end this call?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('End Call'),
          ),
        ],
      ),
    );

    if (shouldLeave == true) {
      await _endCall();
      return false; // Prevent default back behavior since we handle it
    }

    return false; // Don't pop if user cancelled
  }

  void _swapVideos() {
    setState(() {
      _isVideoSwapped = !_isVideoSwapped;
    });
    _log('Videos swapped: local is ${_isVideoSwapped ? "main" : "PIP"}');
  }

  @override
  void dispose() {
    // Remove lifecycle observer
    WidgetsBinding.instance.removeObserver(this);

    // Clear the callback to avoid memory leaks
    widget.agoraService.onAllUsersLeft = null;

    // Cancel all stream subscriptions first
    _remotePollTimer?.cancel();
    _remoteController = null;
    try {
      _localController?.dispose();
    } catch (_) {}

    // Leave channel when widget is disposed (app killed or screen closed)
    // This will notify other users
    widget.agoraService.leaveChannel().catchError((e) {
      _log('Error leaving channel in dispose: $e');
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Main video view (remote by default, local when swapped)
              if (!_isVideoSwapped)
                // Remote video (full screen)
                _buildMainVideo()
              else
                // Local video (full screen when swapped)
                _buildMainLocalVideo(),

              // Loading overlay when not connected
              if (!_isCallConnected)
                Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(color: Colors.white),
                        const SizedBox(height: 24),
                        Text(
                          'Connecting...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Picture-in-picture video (local by default, remote when swapped)
              if (!_isVideoSwapped)
                _buildPipLocalVideo()
              else
                _buildPipRemoteVideo(),

              // Peer nameSara
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.channelName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Controls at the bottom
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Toggle audio
                    FloatingActionButton(
                      heroTag: 'audioButton',
                      onPressed: _toggleAudio,
                      backgroundColor: _isAudioEnabled
                          ? Colors.white
                          : Colors.red,
                      child: Icon(
                        _isAudioEnabled ? Icons.mic : Icons.mic_off,
                        color: _isAudioEnabled ? Colors.black : Colors.white,
                      ),
                    ),

                    // End call
                    FloatingActionButton(
                      heroTag: 'endCallButton',
                      onPressed: _endCall,
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.call_end, color: Colors.white),
                    ),

                    // Toggle video
                    FloatingActionButton(
                      heroTag: 'videoButton',
                      onPressed: _toggleVideo,
                      backgroundColor: _isVideoEnabled
                          ? Colors.white
                          : Colors.red,
                      child: Icon(
                        _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                        color: _isVideoEnabled ? Colors.black : Colors.white,
                      ),
                    ),

                    // Switch camera
                    FloatingActionButton(
                      heroTag: 'switchCameraButton',
                      onPressed: _switchCamera,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.switch_camera,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build main remote video (full screen)
  Widget _buildMainVideo() {
    if (_remoteUid != null && _remoteController != null) {
      return AgoraVideoView(controller: _remoteController!);
    }
    return Container(color: Colors.black);
  }

  // Build main local video (full screen when swapped)
  Widget _buildMainLocalVideo() {
    if (_isVideoEnabled && _localController != null) {
      return AgoraVideoView(controller: _localController!);
    }
    return Container(
      color: Colors.grey.shade800,
      child: const Center(
        child: Icon(Icons.videocam_off, color: Colors.white, size: 100),
      ),
    );
  }

  // Build PIP local video (default)
  Widget _buildPipLocalVideo() {
    return Positioned(
      top: 20,
      right: 20,
      child: GestureDetector(
        onTap: _swapVideos,
        child: Container(
          width: 120,
          height: 160,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _isVideoEnabled && _localController != null
                ? AgoraVideoView(controller: _localController!)
                : Container(
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: Icon(
                        Icons.videocam_off,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // Build PIP remote video (when swapped)
  Widget _buildPipRemoteVideo() {
    return Positioned(
      top: 20,
      right: 20,
      child: GestureDetector(
        onTap: _swapVideos,
        child: Container(
          width: 120,
          height: 160,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _remoteUid != null && _remoteController != null
                ? AgoraVideoView(controller: _remoteController!)
                : Container(
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: Icon(
                        Icons.person_off,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
