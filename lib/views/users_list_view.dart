import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/credits_service.dart';
import '../services/online_users_service.dart';
import '../services/agora_rtm_service.dart';
import 'incoming_call_screen.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({Key? key}) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  final CreditsService _creditsService = CreditsService();
  final OnlineUsersService _onlineService = OnlineUsersService();
  final AgoraRtmService _rtmService = AgoraRtmService();
  List<UserModel> _allUsers = [];
  List<UserModel> _onlineUsers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    
    // Listen to online users changes
    _onlineService.onlineUserIds.addListener(_updateOnlineUsers);
    
    // Setup RTM incoming call listener
    _setupIncomingCallListener();
  }

  void _setupIncomingCallListener() {
    _rtmService.onIncomingCall = (Map<String, dynamic> callData) {
      debugPrint('[USERS_LIST] Incoming call from ${callData['callerName']}');
      
      // Don't show incoming call if already in a call
      final currentRoute = Get.currentRoute;
      if (currentRoute == '/video-call' || currentRoute == '/voice-call') {
        debugPrint('[USERS_LIST] ⚠️ Already in a call, auto-declining incoming call');
        // Auto-decline because user is busy
        _rtmService.sendCallDeclined(callerId: callData['callerId'] as String);
        return;
      }
      
      // Show incoming call screen
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IncomingCallScreen(
              callerId: callData['callerId'] as String,
              callerName: callData['callerName'] as String,
              isVideo: callData['isVideoCall'] as bool,
              channelName: callData['channelName'] as String,
            ),
            fullscreenDialog: true,
          ),
        );
      }
    };
    
    // Listen for call acceptance
    _rtmService.onCallAccepted = (Map<String, dynamic> responseData) {
      final receiverId = responseData['receiverId'] ?? 'Unknown';
      debugPrint('[USERS_LIST] Call accepted by $receiverId');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Call connected!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    };
    
    // Listen for call decline
    _rtmService.onCallDeclined = (Map<String, dynamic> responseData) {
      final receiverId = responseData['receiverId'] ?? 'Unknown';
      debugPrint('[USERS_LIST] Call declined by $receiverId');
      
      // Pop back to users list if we're in a call screen
      if (Get.currentRoute == '/video-call' || Get.currentRoute == '/voice-call') {
        Get.back();
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Call declined'),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(seconds: 2),
        ),
      );
    };
  }

  @override
  void dispose() {
    _onlineService.onlineUserIds.removeListener(_updateOnlineUsers);
    // Don't dispose RTM service here - it's needed globally
    super.dispose();
  }

  void _updateOnlineUsers() {
    if (mounted) {
      setState(() {
        // Get all online user IDs from RTM
        final onlineIds = _onlineService.onlineUserIds.value;
        
        // Create a list of online users
        _onlineUsers = [];
        
        for (final userId in onlineIds) {
          // Skip current user
          if (userId == _onlineService.currentUser?.id) continue;
          
          // Try to find user in predefined list
          UserModel? user = _allUsers.firstWhere(
            (u) => u.id == userId,
            orElse: () => UserModel(
              id: userId,
              name: _extractNameFromUserId(userId),
              age: 0,
              gender: 'Unknown',
              location: 'Unknown',
              isOnline: true,
              agoraUid: userId,
            ),
          );
          
          _onlineUsers.add(user.copyWith(isOnline: true));
        }
        
        debugPrint('[USERS_LIST] Updated UI: ${_onlineUsers.length} online users');
      });
    }
  }
  
  /// Extract display name from user ID
  /// Examples: user_001 → User 1, user_vs_jk_ksjsjd_9860 → Vs Jk Ksjsjd
  String _extractNameFromUserId(String userId) {
    // Remove 'user_' prefix
    String name = userId.replaceFirst('user_', '');
    
    // If it ends with numbers (like _9860), remove them
    name = name.replaceAll(RegExp(r'_\d+$'), '');
    
    // Replace underscores with spaces and capitalize
    name = name.split('_').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
    
    return name.isEmpty ? 'User' : name;
  }

  Future<void> _loadUsers() async {
    // TODO: Backend API call placeholder
    // Example API call:
    // try {
    //   final response = await http.get(
    //     Uri.parse('YOUR_API_URL/users/random'),
    //     headers: {'Authorization': 'Bearer $token'},
    //   );
    //   final List<dynamic> jsonData = jsonDecode(response.body);
    //   _users = jsonData.map((json) => UserModel.fromJson(json)).toList();
    // } catch (e) {
    //   print('Error loading users: $e');
    // }

    // Simulate API call and use test data
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _allUsers = UserModel.generateRandomUsers();
      _updateOnlineUsers();
      _isLoading = false;
    });
  }

  Future<void> _refreshOnlineUsers() async {
    debugPrint('[USERS_LIST] Manual refresh triggered');
    
    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Text('Refreshing online users...'),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );

    // Fetch online users from RTM (will try getOnlineUsers API first)
    await _onlineService.refreshOnlineUsers();
    
    // The _updateOnlineUsers will be called automatically by the listener
    // when onOnlineUsersUpdated callback is triggered
    
    debugPrint('[USERS_LIST] Manual refresh completed');
  }

  void _initiateCall(UserModel user, bool isVideo) async {
    // Check credits before starting call
    if (!_creditsService.canMakeCall(isVideo)) {
      _showInsufficientCreditsDialog(isVideo);
      return;
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('${isVideo ? 'Video' : 'Voice'} Call'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Call ${user.name}?'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, 
                        size: 16, 
                        color: Colors.orange.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Call Charges',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${isVideo ? '80' : '40'} credits per minute',
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available: ${_creditsService.getRemainingCallTime(isVideo)} minutes',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isVideo 
                ? const Color(0xFF667eea) 
                : Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Call'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _startCall(user, isVideo);
    }
  }

  Future<void> _startCall(UserModel user, bool isVideo) async {
    final channelName = 'channel_${user.id}_${DateTime.now().millisecondsSinceEpoch}';
    
    // Send call request via RTM
    final sent = await _rtmService.sendCallRequest(
      receiverId: user.id,
      receiverName: user.name,
      isVideoCall: isVideo,
      channelName: channelName,
    );

    if (!sent) {
      _showError('Failed to send call request. Please try again.');
      return;
    }

    // Navigate to appropriate call screen
    final routeName = isVideo ? '/video-call' : '/voice-call';
    Get.toNamed(
      routeName,
      arguments: {
        'user': user,
        'channelName': channelName,
      },
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showInsufficientCreditsDialog(bool isVideo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade400),
            const SizedBox(width: 12),
            const Text('Insufficient Credits'),
          ],
        ),
        content: Text(
          'You need at least ${isVideo ? '80' : '40'} credits to make a ${isVideo ? 'video' : 'voice'} call.\n\n'
          'Current balance: ${_creditsService.credits.value} credits',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to credits purchase screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Credits purchase coming soon!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667eea),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Buy Credits'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshOnlineUsers,
        backgroundColor: Colors.white,
        tooltip: 'Refresh online users',
        child: const Icon(
          Icons.refresh,
          color: Color(0xFF667eea),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667eea),
              const Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Credits
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find Users',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Start connecting with people',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: _creditsService.credits,
                      builder: (context, credits, _) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: credits < 100
                                    ? Colors.red.shade400
                                    : const Color(0xFFffa000),
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                credits.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: credits < 100
                                      ? Colors.red.shade700
                                      : const Color(0xFF667eea),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              // Users List
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : _onlineUsers.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 80,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No users online',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Check back later or invite friends!',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadUsers,
                            color: const Color(0xFF667eea),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _onlineUsers.length,
                              itemBuilder: (context, index) {
                                final user = _onlineUsers[index];
                                return _buildUserCard(user);
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Picture
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF667eea),
                child: user.profilePic != null
                    ? ClipOval(
                        child: Image.network(
                          user.profilePic!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Text(
                            user.name[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        user.name[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              if (user.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(width: 16),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2d3436),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.cake_outlined,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${user.age} years',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        user.location,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (!user.isOnline)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Offline',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Call Buttons
          Column(
            children: [
              // Voice Call Button
              IconButton(
                onPressed: user.isOnline 
                  ? () => _initiateCall(user, false)
                  : null,
                icon: const Icon(Icons.phone),
                color: Colors.green,
                iconSize: 26,
                style: IconButton.styleFrom(
                  backgroundColor: user.isOnline
                      ? Colors.green.shade50
                      : Colors.grey.shade200,
                  padding: const EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 8),
              // Video Call Button
              IconButton(
                onPressed: user.isOnline
                  ? () => _initiateCall(user, true)
                  : null,
                icon: const Icon(Icons.videocam),
                color: const Color(0xFF667eea),
                iconSize: 26,
                style: IconButton.styleFrom(
                  backgroundColor: user.isOnline
                      ? const Color(0xFF667eea).withOpacity(0.1)
                      : Colors.grey.shade200,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
