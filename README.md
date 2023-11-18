# beer-app
Eine Übersicht über Biersorten und wie sie gebraut werden.

# Voraussetzungen
- Xcode 15
- iOS 16.4

# Aufgabe
Entwickle eine native iOS App, die eine öffentliche API einer Brauerei anspricht und alle Biere in einer Liste darstellt. Ein Tap auf ein Bier öffnet eine View, die detaillierte Informationen aufzeigt.

# Frameworks
Für dieses Projekt wurden zwei SPMs verwendet: Kingfisher und Defaults.

KingFisher ist eine Library, um Bilder runterzuladen und zu cachen.

Defaults vereinfacht die Verwendung von UserDefaults, um Werte persistent in der Defaults Database als Key-Value Paare zu speichern. 

# Features
- API ansprechen und Daten abfangen
- Listenansicht von Bierarten
- Detailseite
- Human Interface Guidelines beachten (Loading, Feedback (Error Handling, Accessibility))

- Pagination
- MVVM Architektur
- Bierarten favorisieren
- Favoritenseite
- Tests für die View Model

# Wie bin ich an die Aufgabe herangegangen?
- Punk API Dokumentation gelesen und in Postman getestet
- Design groß auf Papier skizziert
- Core Features umgesetzt
- Zusätzliche Features umgesetzt
- Tests geschrieben und Code angepasst

# Welche Entscheidung habe ich getroffen?
- Welche Daten von der API anzeigen? Bier soll für den für Endnutzer konzipiert werden. Der Endnutzer ist keine Brauer und interessiert sich nur für Biersorten, die er mal probieren möchte.
- SwiftUI oder UIKit? SwiftUI -> Neuer, einfacher Views zu bauen
- Welche Architektur? MVVM vertrauter
- Welches zusätzliches Feature? Biersorten favorisieren und anzeigen
- Datenbank ja oder nein? Nein, kein Offline Feature Anforderung und es nicht nicht viele Daten. Nur Speicherung von favorisiere Biere in den Defaults.

# Herausforderungen?
- Testen der Veränderung der @Published Variablen -> Über Combine auf Änderungen horchen
- 
