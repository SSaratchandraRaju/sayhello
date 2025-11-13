import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// DebugLogger removed; using print statements for simple logging
import '../services/agora_service.dart';

class CallView extends StatefulWidget {
  final AgoraService agoraService;
  final String channelName;

  const CallView({
    Key? key,
    required this.agoraService,
    required this.channelName,
  }) : super(key: key);

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  void _log(String msg) => print('[CALL] $msg');

  bool _isAudioEnabled = true;
  bool _isVideoEnabled = true;
  bool _isCallConnected = false;
  int? _remoteUid;
  Timer? _remotePollTimer;
  late VideoViewController _localController;
  VideoViewController? _remoteController;

  @override
  void initState() {
  super.initState();
  _initialize();
  }

  Future<void> _initialize() async {
  _log('Initializing Agora call screen for ${widget.channelName}');

    // Start polling for remote UID (simple approach for this migration)
    _remotePollTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      final ruid = widget.agoraService.remoteUid;
      if (ruid != null && ruid != _remoteUid) {
        setState(() {
          _remoteUid = ruid;
          _isCallConnected = true;
          _remoteController = VideoViewController.remote(
            rtcEngine: widget.agoraService.engine,
            canvas: VideoCanvas(uid: ruid),
            connection: RtcConnection(channelId: widget.channelName),
          );
        });
  _log('Detected remote uid: $ruid');
      }
    });

    // Local controller
    _localController = VideoViewController(
      rtcEngine: widget.agoraService.engine,
      canvas: const VideoCanvas(uid: 0),
    );

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

  Future<void> _endCall() async {
  _log('Ending call');
    if (!mounted) return;
    try {
      await widget.agoraService.leaveChannel();
    } catch (e) {
      _log('Error leaving Agora channel: $e');
    }

    _remotePollTimer?.cancel();

    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // Cancel all stream subscriptions first
    _remotePollTimer?.cancel();
    _remoteController = null;
    try {
      _localController.dispose();
    } catch (_) {}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Remote video (full screen)
            if (_remoteUid != null && _remoteController != null)
              AgoraVideoView(controller: _remoteController!)
            else
              Container(color: Colors.black),

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

            // Local video (picture-in-picture)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _isVideoEnabled
                      ? AgoraVideoView(controller: _localController)
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

            // Peer name
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
                    child: const Icon(Icons.switch_camera, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
