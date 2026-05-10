import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MySocApp());
}
//
class AppColors {
  static const blue        = Color(0xFF1A6FD4);
  static const blueLight   = Color(0xFFE8F1FB);
  static const purple      = Color(0xFF7C3AED);
  static const purpleLight = Color(0xFFF0EBFD);
  static const bg          = Color(0xFFF7F8FC);
  static const surface     = Color(0xFFFFFFFF);
  static const textPri     = Color(0xFF0F172A);
  static const textSec     = Color(0xFF64748B);
  static const border      = Color(0xFFE2E8F0);
  static const error       = Color(0xFFDC2626);
  static const errorBg     = Color(0xFFFEF2F2);
}

class MySocApp extends StatelessWidget {
  const MySocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mySoc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.light(
          primary: AppColors.blue,
          secondary: AppColors.purple,
          surface: AppColors.surface,
          onPrimary: Colors.white,
          onSurface: AppColors.textPri,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ─── Background ─────────────────────────────────────────────────────────────


class _AuthBackground extends StatelessWidget {
  const _AuthBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Container(color: AppColors.bg),
          Positioned(
            top: -100, right: -100,
            child: Container(
              width: 340, height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.blue.withOpacity(0.12),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          Positioned(
            bottom: -80, left: -80,
            child: Container(
              width: 280, height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.purple.withOpacity(0.10),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          CustomPaint(size: Size.infinite, painter: _DotPainter()),
        ],
      ),
    );
  }
}

class _DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.blue.withOpacity(0.07)
      ..style = PaintingStyle.fill;
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, p);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

//Brand Header 

class _BrandHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/mysoc_logo.png',
          height: 52,
          errorBuilder: (_, __, ___) => _FallbackLogo(),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.blueLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.blue.withOpacity(0.2)),
          ),
          child: const Text(
            'University App',
            style: TextStyle(
              color: AppColors.blue,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _FallbackLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.blue, AppColors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text('mS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              )),
          ),
        ),
        const SizedBox(width: 8),
        RichText(
          text: const TextSpan(children: [
            TextSpan(text: 'my',
              style: TextStyle(color: AppColors.blue, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
            TextSpan(text: 'Soc',
              style: TextStyle(color: AppColors.purple, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
          ]),
        ),
      ],
    );
  }
}

//Text Field 

class _SocTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  const _SocTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
          style: const TextStyle(
            color: AppColors.textPri,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          )),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: const TextStyle(color: AppColors.textPri, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textSec, fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 14, right: 10),
              child: Icon(icon, color: AppColors.textSec.withOpacity(0.6), size: 18),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.blue, width: 1.8),
            ),
          ),
        ),
      ],
    );
  }
}

//Login Page 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool _obscure    = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _BrandHeader(),
                  const SizedBox(height: 40),
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: 'Welcome\n',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPri,
                          height: 1.1,
                          letterSpacing: -1.2,
                        ),
                      ),
                      TextSpan(
                        text: 'back.',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: AppColors.blue,
                          height: 1.2,
                          letterSpacing: -1.2,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign in to discover your society.',
                    style: TextStyle(fontSize: 15, color: AppColors.textSec),
                  ),
                  const SizedBox(height: 36),
                  _SocTextField(
                    controller: _emailCtrl,
                    label: 'University email',
                    hint: 'you@myport.ac.uk',
                    icon: Icons.alternate_email_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _SocTextField(
                    controller: _passCtrl,
                    label: 'Password',
                    hint: '••••••••',
                    icon: Icons.lock_outline_rounded,
                    obscure: _obscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textSec,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: null,
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sign In button — no action
                  GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SocietiesHomePage(),
      ),
    );
  },
  child: Container(
    width: double.infinity,
    height: 54,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.blue, AppColors.purple],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: AppColors.blue.withOpacity(0.30),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'Sign In',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    ),
  ),
),
                  const SizedBox(height: 32),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColors.textSec, fontSize: 14),
                        ),
                          const Text(
                          'Join mySoc',
                          style: TextStyle(
                            color: AppColors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class Society {
  final String id;
  final String name;
  final String category;
  final String emoji;
  final String description;
  final String meetingTime;
  final String meetingLocation;
  int members;
  bool joined;

  Society({
    required this.id,
    required this.name,
    required this.category,
    required this.emoji,
    required this.members,
    required this.description,
    required this.meetingTime,
    required this.meetingLocation,
    this.joined = false,
  });
}

final _allSocieties = [
  Society(id: '1', name: 'Greek Society',             category: 'Culture', emoji: '🏛️', members: 118,
  description: 'This society celebrates Greek culture and history', meetingTime: 'Mondays 18:00', meetingLocation: 'Student Union Room 2A'),
  Society(id: '2', name: 'Asian Society',             category: 'Culture', emoji: '🏮', members: 204,
  description: 'This society celebrates Asian culture and history', meetingTime: 'Tuesdays 18:00', meetingLocation: 'Student Union Room 2B'),
  Society(id: '3', name: 'American Football Society', category: 'Sport',   emoji: '🏈', members: 87,
  description: 'This society is for indivudals who enjoy playing American football and we accept players of all skill levels', meetingTime: 'Wednesdays 18:00', meetingLocation: 'Portsmouth HMS Temeraire'),
  Society(id: '4', name: 'Tennis Society',            category: 'Sport',   emoji: '🎾', members: 143,
  description: 'This society is for indivudals who enjoy playing tennis and we accept players of all skill levels', meetingTime: 'Thursdays 18:00', meetingLocation: 'Portmouth Tennis Court'),
  Society(id: '5', name: 'Climbing Society',          category: 'Sport',   emoji: '🧗', members: 96,
  description: 'This society is for individuals who enjoy climbing whether it is competitively or just for fun', meetingTime: 'Fridays 18:00', meetingLocation: 'Ravelin Centre'),
  Society(id: '6', name: 'Swimming Society',          category: 'Sport',   emoji: '🏊', members: 111,
  description: 'This society is for individuals who enjoy swimming and we accept people of all skill levels', meetingTime: 'Saturdays 18:00', meetingLocation: 'Ravelin Centre'),
  Society(id: '7', name: 'DJ Society',                category: 'Music',   emoji: '🎧', members: 72,
  description: 'This society is for individuals who enjoy DJing and want to enhance their skills', meetingTime: 'Sundays 13:00', meetingLocation: 'Student Union Room 2C' ),
];


class SocietiesHomePage extends StatefulWidget {
  const SocietiesHomePage({super.key});

  @override
  State<SocietiesHomePage> createState() => _SocietiesHomePageState();
}

class _SocietiesHomePageState extends State<SocietiesHomePage> {
  String _selectedFilter = 'All';
  final _filters = ['All', 'Sport', 'Culture', 'Music'];

  List<Society> get _filtered => _selectedFilter == 'All'
      ? _allSocieties
      : _allSocieties.where((s) => s.category == _selectedFilter).toList();

  void _toggle(Society s) {
    setState(() {
      s.joined = !s.joined;
      if (s.joined) s.members++;
      else s.members--;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: s.joined ? AppColors.blue : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: s.joined ? Colors.transparent : AppColors.border),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        content: Text(
          s.joined ? 'Joined ${s.name}! 🎉' : 'Left ${s.name}.',
          style: TextStyle(
            color: s.joined ? Colors.white : AppColors.textPri,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final joinedCount = _allSocieties.where((s) => s.joined).length;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/mysoc_logo.png',
                        height: 40,
                        errorBuilder: (_, __, ___) => RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: 'my',
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            TextSpan(
                              text: 'Soc',
                              style: TextStyle(
                                color: AppColors.purple,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.blue, AppColors.purple],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(children: [
                          const Icon(Icons.groups_rounded,
                              color: Colors.white, size: 14),
                          const SizedBox(width: 5),
                          Text(
                            '$joinedCount joined',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // ── Title ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: 'Discover\n',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPri,
                              height: 1.1,
                              letterSpacing: -1.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Societies',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: AppColors.blue,
                              height: 1.2,
                              letterSpacing: -1.0,
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_allSocieties.length} societies · Find your society',
                        style: const TextStyle(
                            color: AppColors.textSec, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final active = _filters[i] == _selectedFilter;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedFilter = _filters[i]),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            gradient: active
                                ? const LinearGradient(
                                    colors: [AppColors.blue, AppColors.purple],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )
                                : null,
                            color: active ? null : AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: active
                                  ? Colors.transparent
                                  : AppColors.border,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _filters[i],
                              style: TextStyle(
                                color: active
                                    ? Colors.white
                                    : AppColors.textSec,
                                fontSize: 13,
                                fontWeight: active
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // ── Society cards ──
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _SocietyCard(
                      society: _filtered[i],
                      onToggle: () => _toggle(_filtered[i]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Society Card 

class _SocietyCard extends StatelessWidget {
  final Society society;
  final VoidCallback onToggle;

  const _SocietyCard({
    required this.society,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: society.joined
              ? AppColors.blue.withOpacity(0.35)
              : AppColors.border,
          width: society.joined ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: society.joined
                ? AppColors.blue.withOpacity(0.08)
                : Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: emoji + name + join button 
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: society.joined
                      ? AppColors.blueLight
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(society.emoji,
                      style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      society.name,
                      style: const TextStyle(
                        color: AppColors.textPri,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.purpleLight,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          society.category,
                          style: const TextStyle(
                            color: AppColors.purple,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.people_outline_rounded,
                          size: 12,
                          color: AppColors.textSec.withOpacity(0.6)),
                      const SizedBox(width: 3),
                      Text(
                        '${society.members}',
                        style: const TextStyle(
                            color: AppColors.textSec, fontSize: 12),
                      ),
                    ]),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Join and leave button
              GestureDetector(
                onTap: onToggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: society.joined
                        ? null
                        : const LinearGradient(
                            colors: [AppColors.blue, AppColors.purple],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                    color: society.joined ? AppColors.blueLight : null,
                    borderRadius: BorderRadius.circular(10),
                    border: society.joined
                        ? Border.all(
                            color: AppColors.blue.withOpacity(0.4))
                        : null,
                  ),
                  child: Text(
                    society.joined ? 'Leave' : 'Join',
                    style: TextStyle(
                      color:
                          society.joined ? AppColors.blue : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ── Divider ──
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.border, height: 1),
          ),
          //Description
          Text(
            society.description,
            style: const TextStyle(
              color: AppColors.textSec,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          //Meeting time
          _InfoRow(
            icon: Icons.schedule_rounded,
            label: 'Meeting Time',
            value: society.meetingTime,
          ),
          const SizedBox(height: 8),
          //Meeting location 
          _InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Meeting Location',
            value: society.meetingLocation,
          ),
        ],
      ),
    );
  }
}


class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.blueLight,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Icon(icon, color: AppColors.blue, size: 14),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSec,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPri,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}