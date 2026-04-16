import '../core.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'isDone': isDone,
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = tasks.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList('tasks', data);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('tasks');

    if (data != null) {
      setState(() {
        tasks = data.map((e) => Task.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  void addTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add(Task(title: controller.text.trim()));
      controller.clear();
    });

    saveTasks();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });

    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });

    saveTasks();
  }

  void editTask(int index) {
    controller.text = tasks[index].title;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.clear();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasks[index].title = controller.text.trim();
              });

              saveTasks();
              controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Add a task...',
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, i) {
                  final task = tasks[i];

                  return Card(
                    color: colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (_) => toggleTask(i),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => editTask(i),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteTask(i),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}