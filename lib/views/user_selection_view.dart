import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/online_users_service.dart';

class UserSelectionView extends StatefulWidget {
  const UserSelectionView({Key? key}) : super(key: key);

  @override
  State<UserSelectionView> createState() => _UserSelectionViewState();
}

class _UserSelectionViewState extends State<UserSelectionView> {
  final OnlineUsersService _onlineService = OnlineUsersService();
  late List<UserModel> _availableUsers;
  UserModel? _selectedUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    // TODO: Backend API call placeholder
    // Example API call:
    // try {
    //   final response = await http.get(
    //     Uri.parse('YOUR_API_URL/users/available'),
    //     headers: {'Authorization': 'Bearer $token'},
    //   );
    //   final List<dynamic> jsonData = jsonDecode(response.body);
    //   _availableUsers = jsonData.map((json) => UserModel.fromJson(json)).toList();
    // } catch (e) {
    //   print('Error loading users: $e');
    // }

    // Simulate API call and use test data
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _availableUsers = UserModel.generateRandomUsers();
      _isLoading = false;
    });
  }

  Future<void> _confirmSelection() async {
    if (_selectedUser == null) {
      _showError('Please select a user profile');
      return;
    }

    // Set this user as the current logged-in user
    await _onlineService.setCurrentUser(_selectedUser!);
    
    // Simulate other users being online (for demo)
    _onlineService.simulateOnlineUsers();

    // TODO: Backend API call to associate phone number with selected user
    // Example API call:
    // try {
    //   await http.post(
    //     Uri.parse('YOUR_API_URL/user/select'),
    //     headers: {'Authorization': 'Bearer $token'},
    //     body: {'userId': _selectedUser!.id},
    //   );
    // } catch (e) {
    //   _showError('Failed to select user');
    //   return;
    // }

    // Navigate to preferences screen (skip for now, go directly to users list)
    Get.offAllNamed('/users-list', arguments: {
      'selectedUser': _selectedUser,
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Color(0xFFf093fb),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Your Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose a user profile to continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Users Grid
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: _availableUsers.length,
                        itemBuilder: (context, index) {
                          final user = _availableUsers[index];
                          final isSelected = _selectedUser?.id == user.id;
                          
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedUser = user;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  width: isSelected ? 3 : 1.5,
                                ),
                                boxShadow: [
                                  if (isSelected)
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Profile Picture
                                  Stack(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? const Color(0xFF667eea)
                                              : Colors.white.withOpacity(0.3),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.5),
                                            width: 3,
                                          ),
                                        ),
                                        child: Center(
                                          child: user.profilePic != null
                                              ? ClipOval(
                                                  child: Image.network(
                                                    user.profilePic!,
                                                    width: 74,
                                                    height: 74,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) => Text(
                                                      user.name[0].toUpperCase(),
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : Colors.white.withOpacity(0.9),
                                                        fontSize: 32,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  user.name[0].toUpperCase(),
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.white.withOpacity(0.9),
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 12),
                                  
                                  // User Name
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      user.name,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? const Color(0xFF667eea)
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 4),
                                  
                                  // User Info
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cake_outlined,
                                        size: 12,
                                        color: isSelected
                                            ? const Color(0xFF667eea).withOpacity(0.7)
                                            : Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${user.age}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isSelected
                                              ? const Color(0xFF667eea).withOpacity(0.7)
                                              : Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        user.gender.toLowerCase() == 'male'
                                            ? Icons.male
                                            : Icons.female,
                                        size: 12,
                                        color: isSelected
                                            ? const Color(0xFF667eea).withOpacity(0.7)
                                            : Colors.white.withOpacity(0.7),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 4),
                                  
                                  // Location
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 12,
                                        color: isSelected
                                            ? const Color(0xFF667eea).withOpacity(0.7)
                                            : Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          user.location,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: isSelected
                                                ? const Color(0xFF667eea).withOpacity(0.7)
                                                : Colors.white.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              
              // Continue Button
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _selectedUser != null ? _confirmSelection : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF667eea),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          disabledBackgroundColor: Colors.white.withOpacity(0.3),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Create Custom Profile Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed('/profile-setup');
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text(
                          'Create Custom Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        // Skip user selection and go directly to preferences
                        Get.offAllNamed('/preferences');
                      },
                      child: Text(
                        'Skip for now',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
}
