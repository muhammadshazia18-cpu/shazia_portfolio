import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ShaziaPortfolioApp());
}

class ShaziaPortfolioApp extends StatelessWidget {
  const ShaziaPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muhammad Shazia | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: PortfolioColors.paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: PortfolioColors.teal,
          primary: PortfolioColors.teal,
          surface: PortfolioColors.paper,
        ),
        fontFamily: 'Arial',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioColors {
  static const ink = Color(0xFF182B28);
  static const muted = Color(0xFF66736F);
  static const teal = Color(0xFF16796E);
  static const lime = Color(0xFFD9F27A);
  static const coral = Color(0xFFE9785B);
  static const paper = Color(0xFFF5F7F2);
  static const line = Color(0xFFDDE4DC);
  static const white = Color(0xFFFFFFFF);
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _openLink(String value) async {
    final uri = Uri.parse(value);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;
          final horizontalPadding = constraints.maxWidth < 500 ? 22.0 : 48.0;
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1240),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildNavigation(isWide),
                      _buildHero(isWide),
                      _buildAbout(isWide),
                      const SizedBox(height: 88),
                      _buildProjects(),
                      const SizedBox(height: 88),
                      _buildSkills(isWide),
                      const SizedBox(height: 88),
                      _buildExperience(isWide),
                      _buildContact(isWide),
                      const SizedBox(height: 24),
                      _buildFooter(isWide),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigation(bool isWide) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PortfolioColors.ink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'MS',
              style: TextStyle(
                color: PortfolioColors.lime,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'MUHAMMAD SHAZIA',
            style: TextStyle(
              color: PortfolioColors.ink,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          if (isWide) ...[
            _NavLink(label: 'About', onTap: () => _scrollTo(_aboutKey)),
            _NavLink(label: 'Projects', onTap: () => _scrollTo(_projectsKey)),
            _NavLink(label: 'Experience', onTap: () => _scrollTo(_experienceKey)),
            const SizedBox(width: 12),
            _SmallButton(
              label: 'Let’s talk',
              onPressed: () => _scrollTo(_contactKey),
            ),
          ] else
            PopupMenuButton<String>(
              tooltip: 'Open navigation',
              icon: const Icon(Icons.menu_rounded, color: PortfolioColors.ink),
              onSelected: (value) {
                if (value == 'About') _scrollTo(_aboutKey);
                if (value == 'Projects') _scrollTo(_projectsKey);
                if (value == 'Experience') _scrollTo(_experienceKey);
                if (value == 'Contact') _scrollTo(_contactKey);
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'About', child: Text('About')),
                PopupMenuItem(value: 'Projects', child: Text('Projects')),
                PopupMenuItem(value: 'Experience', child: Text('Experience')),
                PopupMenuItem(value: 'Contact', child: Text('Contact')),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildHero(bool isWide) {
    final introduction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Eyebrow(label: 'COMPUTER SCIENCE STUDENT  /  DEVELOPER'),
        const SizedBox(height: 24),
        Text(
          'Curious mind.\nThoughtful code.',
          style: TextStyle(
            color: PortfolioColors.ink,
            fontSize: isWide ? 66 : 48,
            height: 1.03,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.8,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'I’m Muhammad Shazia, a Computer Science and Engineering student who enjoys building useful things with Java, Python, and data.',
          style: TextStyle(
            color: PortfolioColors.muted,
            fontSize: 17,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _PrimaryButton(
              label: 'Explore my work',
              icon: Icons.arrow_downward_rounded,
              onPressed: () => _scrollTo(_projectsKey),
            ),
            _OutlineButton(
              label: 'Get in touch',
              onPressed: () => _scrollTo(_contactKey),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: const [
            _SkillTag(label: 'Java'),
            _SkillTag(label: 'Python'),
            _SkillTag(label: 'Machine learning'),
            _SkillTag(label: 'SQL'),
          ],
        ),
      ],
    );

    final profilePanel = Container(
      height: 430,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: PortfolioColors.ink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/image.png', fit: BoxFit.cover, alignment: Alignment.topCenter),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  PortfolioColors.ink.withOpacity(0.15),
                  PortfolioColors.ink.withOpacity(0.96),
                ],
                stops: const [0.35, 0.58, 1],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: PortfolioColors.ink.withOpacity(0.82),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'COMPUTER SCIENCE STUDENT',
                style: TextStyle(
                  color: PortfolioColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '8.53',
                  style: TextStyle(
                    color: PortfolioColors.lime,
                    fontWeight: FontWeight.w800,
                    fontSize: 68,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'CGPA  /  B.Tech CSE',
                  style: TextStyle(
                    color: PortfolioColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(color: Color(0xFF71807A), height: 1),
                const SizedBox(height: 12),
                const Text(
                  'BVRIT Hyderabad College of Engineering for Women',
                  style: TextStyle(
                    color: Color(0xFFE1E8E4),
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(top: isWide ? 66 : 42, bottom: 88),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: introduction),
                const SizedBox(width: 70),
                Expanded(flex: 4, child: profilePanel),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                introduction,
                const SizedBox(height: 40),
                profilePanel,
              ],
            ),
    );
  }

  Widget _buildAbout(bool isWide) {
    return Column(
      key: _aboutKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          eyebrow: 'THE FOUNDATION',
          title: 'Education',
          detail: 'Learning the principles behind the products I build.',
        ),
        const SizedBox(height: 30),
        _EducationRow(
          isWide: isWide,
          years: '2025 — 2028',
          school: 'BVRIT Hyderabad College of Engineering for Women',
          location: 'Hyderabad, India',
          qualification: 'B.Tech, Computer Science and Engineering',
          result: 'CGPA 8.53 / 10',
          accent: PortfolioColors.teal,
        ),
        _EducationRow(
          isWide: isWide,
          years: '2022 — 2025',
          school: 'Government Polytechnic Hyderabad',
          location: 'Hyderabad, India',
          qualification: 'Diploma, Computer Science Engineering',
          result: 'CGPA 9.3 / 10',
          accent: PortfolioColors.coral,
        ),
        _EducationRow(
          isWide: isWide,
          years: '2022',
          school: 'Warangal Public School',
          location: 'Warangal, India',
          qualification: 'Secondary Education, CBSE',
          result: '91%',
          accent: PortfolioColors.ink,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildProjects() {
    const projects = [
      ProjectData(
        number: '01',
        title: 'Laptop & Sofa Price Prediction Systems',
        year: '2025',
        stack: 'Python  ·  Machine Learning',
        description:
            'Built price prediction models from marketplace data, with web scraping, preprocessing, and feature engineering.',
        outcome:
            'Applied regression algorithms and data visualization to improve model predictions.',
        color: PortfolioColors.teal,
        icon: Icons.query_stats_rounded,
      ),
      ProjectData(
        number: '02',
        title: 'Secure Password Generator',
        year: '2024',
        stack: 'Java  ·  Object-Oriented Programming',
        description:
            'Created a customizable password generator with configurable length and character sets.',
        outcome:
            'Used secure generation rules to create high-strength passwords.',
        color: PortfolioColors.coral,
        icon: Icons.password_rounded,
      ),
      ProjectData(
        number: '03',
        title: 'Employee Attendance Management',
        year: '2024',
        stack: 'Java  ·  MySQL',
        description:
            'Built an application to manage employee attendance, records, and reporting.',
        outcome:
            'Designed a database schema for efficient storage and retrieval.',
        color: PortfolioColors.ink,
        icon: Icons.fact_check_outlined,
      ),
    ];

    return Column(
      key: _projectsKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          eyebrow: 'SELECTED WORK',
          title: 'Projects',
          detail: 'Small, practical builds across data and application development.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 940
                ? 3
                : constraints.maxWidth >= 620
                    ? 2
                    : 1;
            final gap = 16.0;
            final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final project in projects)
                  SizedBox(
                    width: cardWidth,
                    child: _ProjectCard(project: project),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildSkills(bool isWide) {
    const groups = [
      SkillGroup(
        title: 'Languages & tools',
        skills: ['Java', 'Python', 'SQL', 'Git', 'Tableau', 'Excel'],
        color: PortfolioColors.teal,
      ),
      SkillGroup(
        title: 'Platforms',
        skills: ['Windows', 'Linux', 'VS Code', 'Eclipse', 'Google Colab', 'MySQL Workbench'],
        color: PortfolioColors.coral,
      ),
      SkillGroup(
        title: 'Coursework',
        skills: [
          'Data Structures',
          'OOP',
          'Database Management',
          'Discrete Mathematics',
        ],
        color: PortfolioColors.ink,
      ),
      SkillGroup(
        title: 'How I work',
        skills: ['Communication', 'Teamwork', 'Problem solving', 'Time management'],
        color: PortfolioColors.teal,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          eyebrow: 'TOOLKIT',
          title: 'Skills & tools',
          detail: 'A growing toolkit grounded in computer science fundamentals.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 920
                ? 4
                : constraints.maxWidth >= 600
                    ? 2
                    : 1;
            final gap = 18.0;
            final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: 26,
              children: [
                for (final group in groups)
                  SizedBox(
                    width: width,
                    child: _SkillGroupView(group: group),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildExperience(bool isWide) {
    const items = [
      ExperienceData(
        title: 'CodeChef · Data Structures (CS302PC)',
        year: '2025',
        detail: 'Coursework in data structure fundamentals and applications.',
      ),
      ExperienceData(
        title: 'CodeChef · Object-Oriented Programming Through Java',
        year: '2025',
        detail: 'Applied object-oriented programming principles using Java.',
      ),
      ExperienceData(
        title: 'Smart India Hackathon',
        year: '2025',
        detail: 'Collaborated on a real-world problem through brainstorming and prototyping.',
      ),
      ExperienceData(
        title: 'Pure Earth Conference',
        year: '2025',
        detail: 'Certificate of participation at an environmental conference.',
      ),
      ExperienceData(
        title: 'National Financial Literacy Quiz',
        year: '2026',
        detail: 'Participation certificate for the financial literacy quiz competition.',
      ),
    ];

    return Column(
      key: _experienceKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          eyebrow: 'BEYOND THE CLASSROOM',
          title: 'Certifications & activities',
          detail: 'Learning, building, and working through ideas with a team.',
        ),
        const SizedBox(height: 28),
        for (var index = 0; index < items.length; index++)
          _ExperienceRow(
            item: items[index],
            isWide: isWide,
            isLast: index == items.length - 1,
          ),
      ],
    );
  }

  Widget _buildContact(bool isWide) {
    return Container(
      key: _contactKey,
      margin: const EdgeInsets.only(top: 88),
      padding: EdgeInsets.all(isWide ? 44 : 26),
      decoration: BoxDecoration(
        color: PortfolioColors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: isWide
          ? Row(
              children: [
                const Expanded(child: _ContactCopy()),
                const SizedBox(width: 36),
                _ContactActions(openLink: _openLink),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _ContactCopy(),
                const SizedBox(height: 24),
                _ContactActions(openLink: _openLink),
              ],
            ),
    );
  }

  Widget _buildFooter(bool isWide) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 4),
      child: isWide
          ? Row(
              children: const [
                Text(
                  '© 2026 Muhammad Shazia',
                  style: TextStyle(color: PortfolioColors.muted, fontSize: 12),
                ),
                Spacer(),
                Text(
                  'DESIGNED & BUILT WITH FLUTTER',
                  style: TextStyle(
                    color: PortfolioColors.muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            )
          : const Text(
              '© 2026 Muhammad Shazia  ·  Built with Flutter',
              style: TextStyle(color: PortfolioColors.muted, fontSize: 12),
            ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 24, height: 2, color: PortfolioColors.coral),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              color: PortfolioColors.teal,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.detail,
  });

  final String eyebrow;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Eyebrow(label: eyebrow),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: PortfolioColors.ink,
            fontSize: 34,
            height: 1.1,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          detail,
          style: const TextStyle(
            color: PortfolioColors.muted,
            fontSize: 15,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _EducationRow extends StatelessWidget {
  const _EducationRow({
    required this.isWide,
    required this.years,
    required this.school,
    required this.location,
    required this.qualification,
    required this.result,
    required this.accent,
    this.isLast = false,
  });

  final bool isWide;
  final String years;
  final String school;
  final String location;
  final String qualification;
  final String result;
  final Color accent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: PortfolioColors.line),
          bottom: isLast
              ? const BorderSide(color: PortfolioColors.line)
              : BorderSide.none,
        ),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    years,
                    style: const TextStyle(
                      color: PortfolioColors.muted,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 3,
                  height: 56,
                  margin: const EdgeInsets.only(right: 20),
                  color: accent,
                ),
                Expanded(child: _EducationDetails(
                  school: school,
                  location: location,
                  qualification: qualification,
                  result: result,
                )),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 3,
                  height: 76,
                  margin: const EdgeInsets.only(right: 14),
                  color: accent,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        years,
                        style: const TextStyle(
                          color: PortfolioColors.teal,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 7),
                      _EducationDetails(
                        school: school,
                        location: location,
                        qualification: qualification,
                        result: result,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _EducationDetails extends StatelessWidget {
  const _EducationDetails({
    required this.school,
    required this.location,
    required this.qualification,
    required this.result,
  });

  final String school;
  final String location;
  final String qualification;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          school,
          style: const TextStyle(
            color: PortfolioColors.ink,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$qualification  ·  $location',
          style: const TextStyle(
            color: PortfolioColors.muted,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          result,
          style: const TextStyle(
            color: PortfolioColors.teal,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class ProjectData {
  const ProjectData({
    required this.number,
    required this.title,
    required this.year,
    required this.stack,
    required this.description,
    required this.outcome,
    required this.color,
    required this.icon,
  });

  final String number;
  final String title;
  final String year;
  final String stack;
  final String description;
  final String outcome;
  final Color color;
  final IconData icon;
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});
  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 290),
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: PortfolioColors.white,
        border: Border.all(color: PortfolioColors.line),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: project.color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(project.icon, color: project.color, size: 22),
              ),
              const Spacer(),
              Text(
                project.year,
                style: const TextStyle(
                  color: PortfolioColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Text(
            project.title,
            style: const TextStyle(
              color: PortfolioColors.ink,
              fontSize: 19,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project.stack,
            style: TextStyle(
              color: project.color,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            project.description,
            style: const TextStyle(
              color: PortfolioColors.muted,
              height: 1.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            project.outcome,
            style: const TextStyle(
              color: PortfolioColors.ink,
              height: 1.5,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillGroup {
  const SkillGroup({required this.title, required this.skills, required this.color});
  final String title;
  final List<String> skills;
  final Color color;
}

class _SkillGroupView extends StatelessWidget {
  const _SkillGroupView({required this.group});
  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 28, height: 3, color: group.color),
        const SizedBox(height: 13),
        Text(
          group.title,
          style: const TextStyle(
            color: PortfolioColors.ink,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [for (final skill in group.skills) _SkillTag(label: skill)],
        ),
      ],
    );
  }
}

class _SkillTag extends StatelessWidget {
  const _SkillTag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEE7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: PortfolioColors.ink,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ExperienceData {
  const ExperienceData({required this.title, required this.year, required this.detail});
  final String title;
  final String year;
  final String detail;
}

class _ExperienceRow extends StatelessWidget {
  const _ExperienceRow({
    required this.item,
    required this.isWide,
    required this.isLast,
  });

  final ExperienceData item;
  final bool isWide;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: const TextStyle(
            color: PortfolioColors.ink,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          item.detail,
          style: const TextStyle(
            color: PortfolioColors.muted,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: PortfolioColors.line),
          bottom: isLast
              ? const BorderSide(color: PortfolioColors.line)
              : BorderSide.none,
        ),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    item.year,
                    style: const TextStyle(
                      color: PortfolioColors.teal,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(child: content),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.year,
                  style: const TextStyle(
                    color: PortfolioColors.teal,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                content,
              ],
            ),
    );
  }
}

class _ContactCopy extends StatelessWidget {
  const _ContactCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'HAVE A PROJECT IN MIND?',
          style: TextStyle(
            color: PortfolioColors.lime,
            fontSize: 11,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Let’s make something useful.',
          style: TextStyle(
            color: PortfolioColors.white,
            fontSize: 30,
            height: 1.15,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Reach out for collaboration, opportunities, or a good conversation about code.',
          style: TextStyle(
            color: Color(0xFFD2E5DF),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _ContactActions extends StatelessWidget {
  const _ContactActions({required this.openLink});
  final ValueChanged<String> openLink;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _ContactButton(
          label: 'Email me',
          icon: Icons.mail_outline_rounded,
          onPressed: () => openLink('mailto:muhammadshazia18@gmail.com'),
        ),
        _ContactButton(
          label: 'Call',
          icon: Icons.call_outlined,
          onPressed: () => openLink('tel:+919392213037'),
        ),
        _ContactButton(
          label: 'GitHub',
          icon: Icons.code_rounded,
          onPressed: () => openLink('https://github.com/muhammadshazia18-cpu'),
        ),
        _ContactButton(
          label: 'LinkedIn',
          icon: Icons.work_outline_rounded,
          onPressed: () => openLink('https://linkedin.com/in/muhammad-shazia-0b035837a/'),
        ),
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: FilledButton.styleFrom(
        foregroundColor: PortfolioColors.ink,
        backgroundColor: PortfolioColors.lime,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(foregroundColor: PortfolioColors.ink),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _SmallButton extends StatelessWidget {
  const _SmallButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: PortfolioColors.ink,
        foregroundColor: PortfolioColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(label),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: PortfolioColors.teal,
        foregroundColor: PortfolioColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: PortfolioColors.ink,
        side: const BorderSide(color: PortfolioColors.line),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(label),
    );
  }
}