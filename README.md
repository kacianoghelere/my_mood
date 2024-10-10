# Mood Tracker App
The **Mood Tracker App** allows users to monitor their mood variations over time and log possible causes for each entry. Users can record their mood on a scale from 1 to 5, ranging from "very dissatisfied" to "very satisfied," along with optional notes to provide more context. Each entry is automatically timestamped with the current date and time at the moment of creation.

#### Key Features:
- **Mood Recording**: Users can log their current mood using a sliding scale, accompanied by an icon that visually represents the mood (e.g., very dissatisfied, neutral, very satisfied).
- **Detailed Notes**: Add optional notes to explain possible causes or details about the recorded mood.
- **Daily Grouped Logs**: The app displays mood entries in a list grouped by day, making it easy to see the overall emotional trend on any given day.
- **Editing and Deleting Entries**: Users can edit or delete their mood entries directly from the list.
- **Mood Report**: A dedicated report screen allows users to view a graphical analysis of their mood trends over a selected period (last 7, 15, or 30 days), showing the predominant mood as well as a bar chart of mood frequencies.
- **State Management**: The app uses the `Provider` package for state management, ensuring smooth and efficient updates to the user interface.
- **Data Persistence**: The app uses `Isar`, a NoSQL database, to store mood entries locally, enabling persistent storage and fast querying.

#### Mood Report:
The report feature enables users to gain insights into their emotional trends by providing:
- A **predominant mood** indicator based on the most frequently logged mood in the selected time period.
- A **bar chart** that shows how often each mood (very dissatisfied to very satisfied) was recorded, helping users visualize their emotional journey over time.

#### Technology Stack:
- **Flutter**: Cross-platform mobile framework for building high-performance apps on iOS and Android.
- **Provider**: For state management and efficient UI updates.
- **Isar**: NoSQL database for fast and reliable local data storage.
- **fl_chart**: For rendering the mood frequency bar chart in the report section.

This app is a useful tool for individuals looking to track their emotional well-being, understand mood patterns, and identify potential triggers for mood changes.