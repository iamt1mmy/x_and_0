# 🎮 X & 0 — Joc vesel, modern și surprinzător

Bine ai venit la X & 0 — un joc mic cu suflet mare, construit cu pasiune. Acest proiect aduce o interfață neon, animații jucăușe și opțiuni atât pentru doi jucători locali, cât și pentru a concura contra unui AI cu nivele de dificultate. Joacă rapid, zâmbește la animații și bucură-te de mici detalii care fac experiența plăcută.

## ✨ Features
- Interfață modernă cu efecte neon și glassmorphism.
- Animații pentru apariția simbolurilor și overlay de celebrare.
- Moduri de joc: `2 Players (Local)` și `Vs AI` (Easy / Medium / Hard).
- AI implementat cu Minimax la nivel `Hard` — decizii optimizate.
- Scoruri pentru `X`, `O` și `Draws` afișate persistent pe durata rulării.
- Toate textele UI extrase în `lib/strings/strings.dart` pentru ușoară localizare.

## 🚀 Run or Install
- Cerințe: `flutter` (stable), SDK Dart compatibil cu `pubspec.yaml`.
- Pași rapizi pentru a rula local:

```bash
flutter pub get
flutter analyze
flutter run
```

- Recomandare: folosește un dispozitiv/ emulator cu ecran vertical pentru cea mai bună experiență.

## 🛠️ Development
- Puncte de start pentru modificări:
   - `lib/screens/home_screen.dart` — logica principală: stare board, mutări, scor, animații.
   - `lib/widgets/board_widget.dart` și `lib/widgets/cell_widget.dart` — UI grilă și celule.
   - `lib/data/game_logic.dart` — detectare câștigător (`winningComboForBoard`, `checkWinner`).
   - `lib/data/ai.dart` — implementarea AI (`getAIMove`, `_minimax`).
   - `lib/strings/strings.dart` — toate textele UI.

- Sugestii rapide:
   - Rulează `flutter analyze` după schimbări.
   - Teste recomandate: scrie unit tests pentru `checkWinner()` și `getAIMove()`.

## 🤝 Contributing
- Vrei să contribui? Mulțumim! Pași sugerați:
   1. Fork sau clonează repository-ul.
   2. Creează un branch clar descriptivă: `feature/descriere` sau `fix/descriere`.
   3. Respectă stilul codului existent și rulează `flutter analyze`.
   4. Deschide un Pull Request cu descrierea schimbărilor și pași de testare.

- Guidelines:
   - Evită string-uri hardcodate în widget-uri — folosește `lib/strings/strings.dart`.
   - Păstrează widget-urile cât mai mici și reutilizabile.

## 🕰️ Legacy project
- Notă: această bază de cod este concepută ca un proiect mic, ușor de extins. Dacă integrezi funcționalități majore (persistență, multiplayer online, sau audio extensiv), marchează acele modificări ca parte a migrării și documentează clar schimbările arhitecturale.
- Recomandări pentru legacy:
   - Pentru persistență: `shared_preferences` pentru setări, `hive`/`sqflite` pentru stări mai complexe.
   - Pentru multiplayer real-time: consideră integrarea WebSocket / Firebase.
