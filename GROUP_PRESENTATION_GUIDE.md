# 📋 GROUP PRESENTATION GUIDE - NEW SPLIT

## ✅ NEW PERSON ASSIGNMENTS (EQUALLY BALANCED)

### **Person 1 - App Startup (3 min)**
**File:** `lib/main.dart`
- `main()` function - Hive initialization
- Provider setup
- Theme setup (Colors.teal)

---

### **Person 2 - Task Data Structure (2 min)**
**File:** `lib/models/task_model.dart`
- Task class properties (5 properties)
- TaskAdapter for phone storage
- BinaryReader/Writer concept

---

### **Person 3 - Task Management Engine (8 min)**
**File:** `lib/providers/todo_provider.dart`
- `loadTasks()` - Loading & sorting
- `addTask()` - Creating new task
- `updateTask()` - Modifying task
- `deleteTask()` - Removing task
- ChangeNotifier (state management)
- Sorting logic (pending → completed)

---

### **Person 4 - Navigation System (4 min)**
**File:** `lib/screens/home_screen.dart` (TOP PART)
- Bottom navigation bar (3 tabs)
- AppBar
- `currentIndex` state switching
- Floating action button (+)
- `getPriorityColor()` helper method


---

### **Person 5 - Tasks List Display (6 min)**
**File:** `lib/screens/home_screen.dart` (BOTTOM PART - buildTasksScreen)
- ListView.builder displaying tasks
- Checkbox to mark complete
- Edit button → opens AddEditScreen
- Delete button with confirmation
- Dismissible (swipe to delete)
- Consumer pattern (watching Provider)


---

### **Person 6 - Form & Validation (5 min)**
**File:** `lib/screens/add_edit_screen.dart`
- TextFormField with validation
- Description input (optional)
- DropdownButton for priority
- Form submission logic
- `saveTask()` method
- New vs Edit detection


---

### **Person 7 - Data Views (4 min)**
**Files:** 
- `lib/screens/stats_screen.dart` - Counting & statistics
- `lib/screens/completed_tasks_screen.dart` - Filtering & display

- Total/Pending/Completed counts
- Priority breakdown (High/Medium/Low)
- For loops for counting
- Filtering completed tasks


---

## 📊 TIME BREAKDOWN
| Person | Topic | Time | Difficulty |
|--------|-------|------|------------|
| 1 | App Startup | 3 min | ⭐ |
| 2 | Task Model | 2 min | ⭐ |
| 3 | Provider Logic | 8 min | ⭐⭐⭐ |
| 4 | Navigation | 4 min | ⭐⭐ |
| 5 | Task List | 6 min | ⭐⭐ |
| 6 | Form Handling | 5 min | ⭐⭐ |
| 7 | Stats & Views | 4 min | ⭐⭐ |
| **TOTAL** | | **32 min** | Balanced |

---

## 🎯 PRESENTATION FLOW

**Start:** "How does this app work when you open it?"
1. Person 1 explains: App opens → Hive starts → Provider loads
2. Person 2 explains: Task structure created
3. Person 3 explains: Tasks loaded from storage, sorted
4. Person 4 explains: HomeScreen shows navigation
5. Person 5 explains: Tasks displayed in list
6. Person 6 explains: User can add/edit via form
7. Person 7 explains: User can view stats and completed tasks

---

## 💡 KEY POINTS FOR EACH PERSON

**Person 1:** "Without this setup, nothing works"
**Person 2:** "This is what we're storing in the phone"
**Person 3:** "This is the brain - all data operations happen here"
**Person 4:** "This is the main screen - let's navigate!"
**Person 5:** "These are the tasks - let's interact with them"
**Person 6:** "User creates tasks here"
**Person 7:** "User views summaries here"

---

## 📍 CODE COMMENTS LOCATION

Every file now has `// Person X:` comments showing exactly what code each person explains.

**To find your section:**
1. Open your assigned file(s)
2. Look for `// Person X:` comment
3. Explain that code block

---

## 🔄 DATA FLOW EXAMPLES

### When User Adds Task:
```
Person 4: User taps + button (FAB)
    ↓
Person 6: Form opens
    ↓
Person 6: User fills & submits
    ↓
Person 3: addTask() saves to Hive
    ↓
Person 3: loadTasks() reloads
    ↓
Person 5: ListView refreshes to show new task
```

### When User Checks Checkbox:
```
Person 5: User taps checkbox
    ↓
Person 3: updateTask() modifies task
    ↓
Person 3: Sorting logic moves task to bottom
    ↓
Person 5: Screen updates with new order
```

### When User Views Stats:
```
Person 4: User taps "Stats" tab
    ↓
Person 7: StatsScreen builds
    ↓
Person 7: For loops count each type
    ↓
Person 7: Cards display the counts
```

---

## ✨ TIPS FOR YOUR PRESENTATION

1. **Start simple** - Person 1 & 2 set the stage
2. **Then explain logic** - Person 3 is the hardest, give them time
3. **Show the UI** - Person 4 & 5 show what people see
4. **Explain interactions** - Person 6 shows user input
5. **Finish with features** - Person 7 shows extra features
6. **Use code comments** - Read the `// Person X:` comments directly
7. **Show the app working** - Run it while presenting!

---

## 🎓 STUDY TIPS

- **Person 1:** Understand async/await basics
- **Person 2:** Understand classes and properties
- **Person 3:** Understand Future, sorting, and state management
- **Person 4:** Understand Scaffold, AppBar, navigation concepts
- **Person 5:** Understand ListView, Consumer, and widgets
- **Person 6:** Understand Form validation and setState
- **Person 7:** Understand filtering and counting loops
