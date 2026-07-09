# Student Grade Tracker App (Module-05)

A robust, reactive Flutter application designed to track course achievements, calculate letter grades, and display performance analytics in real-time. Built as part of the Android Development Bootcamp training.

---

## 📱 Features & Architecture

This application fully meets all assignment specifications, implementing a decoupled state-conscious design without hardcoded visual elements:

* **Three Screen Layout**: Switch seamlessly between **Add Subject**, **Subject List**, and **Performance Summary** via an intuitive `BottomNavigationBar`.
* **Dynamic Theme Toggle Engine**: Built-in support for custom Light and Dark modes (`ThemeData`), fully utilizing dynamic color schemes from `Theme.of(context)` with absolutely zero hardcoded hex colors in the UI components.
* **Zero `setState` Calls**: App state is globally managed utilizing the **Provider** package, maintaining crisp data flow separation.
* **Swipe-to-Delete**: Seamless list updates utilizing the interactive `Dismissible` widget constraint framework.

---

## 🛠️ Assignment Technical Requirements Met

* **Encapsulated Model Matrix**: The `Subject` class strictly encloses a private `_mark` field with a reactive calculated `grade` getter parsing score boundaries ($A \ge 80$, $B \ge 65$, $C \ge 50$, $F$).
* **Functional Array Processing**: Implements the `.where()` functional iterable filter to dynamically isolate passing courses ($mark \ge 50$).
* **Rigid Form Validation**: The user inputs are strictly audited ensuring name configurations are never empty and marks are tightly bound within the $0 \le \text{mark} \le 100$ boundary limit.
* **Live-Updated Summary Analytics**: Live synchronization showing Total Subjects, Average Mark percentages, and the overall cumulative Letter Grade instantly when rows are added or swiped away.

---

## 📂 Project Structure

```text
lib/
├── models/
│   └── subject.dart            # Pure Object domain encapsulating private fields
├── providers/
│   └── tracker_provider.dart   # ChangeNotifer orchestrating state mutation rules
├── screens/
│   ├── add_subject_screen.dart # Form structure featuring conditional layout checks
│   ├── subject_list_screen.dart# ListView renderer with Dismissible hooks
│   └── summary_screen.dart     # Analytic metrics calculator 
├── main.dart                   # Global multi-theme injector configurations
└── main_screen.dart            # Parent Scaffold controlling view layers