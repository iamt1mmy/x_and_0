# 🎮 X & 0 — Documentație aplicație

Un proiect Flutter simplu și modular pentru jocul X & 0, cu 2 jucători și versus AI (Easy / Medium / Hard). Această documentație explică structura codului, componentele principale, modul de funcționare al AI-ului și cum să rulezi sau extinzi aplicația.


**⬇️ Scurtă prezentare**
- **Ce este**: Aplicatie mobilă X & 0 cu interfață modernă (glassmorphism + neon), animații și AI cu Minimax (nivel Hard).
- **Moduri de joc**: *Local* (2 jucători pe același dispozitiv) și *VS AI* (X = jucător, O = AI).


**📁 Structură proiect**
- **`lib/`**: codul sursă Flutter.
	- **`lib/main.dart`**: punctul de intrare; lansează app-ul (`TicTacToeApp`). Vezi [lib/main.dart](lib/main.dart).
	- **`lib/screens/app.dart`**: container principal și gestionare temă. Vezi [lib/screens/app.dart](lib/screens/app.dart).
	- **`lib/screens/home_screen.dart`**: ecranul principal cu logica jocului (stare board, control joc, legături către widgeturi). Vezi [lib/screens/home_screen.dart](lib/screens/home_screen.dart).
	- **`lib/screens/settings_screen.dart`**: ecran pentru selectat *GameMode* și *AIDifficulty*. Vezi [lib/screens/settings_screen.dart](lib/screens/settings_screen.dart).
	- **`lib/widgets/`**: componente UI reutilizabile (celule, tablou, overlay de celebrări).
		- `lib/widgets/cell_widget.dart` — randare animată X / O. Vezi [lib/widgets/cell_widget.dart](lib/widgets/cell_widget.dart).
		- `lib/widgets/board_widget.dart` — grilă 3x3, delegă tap‑uri. Vezi [lib/widgets/board_widget.dart](lib/widgets/board_widget.dart).
		- `lib/widgets/home_header.dart`, `lib/widgets/score_row_widget.dart`, `lib/widgets/actions_widget.dart`, `lib/widgets/celebration_overlay.dart` — componente mici care compun `HomeScreen`.
	- **`lib/data/`**: logică de joc și AI.
		- `lib/data/game_logic.dart` — detectare winner, combinații câștigătoare. Vezi [lib/data/game_logic.dart](lib/data/game_logic.dart).
		- `lib/data/ai.dart` — implementare AI (Easy: random, Medium: heuristici simple, Hard: Minimax). Vezi [lib/data/ai.dart](lib/data/ai.dart).
	- **`lib/models/enums.dart`**: enumuri `GameMode` și `AIDifficulty`. Vezi [lib/models/enums.dart](lib/models/enums.dart).

- **`test/`**: teste widget (ex. `test/widget_test.dart`). Vezi [test/widget_test.dart](test/widget_test.dart).

**🧩 Componente cheie și rolul lor**
- **`HomeScreen`**: deține starea jocului — `_board` (lista de 9 stringuri), `_currentPlayer`, `_score`, `_winningCombo`, animatoare. Interacțiunea de bază este în `_makeMove(index)`, care:
	- validează mutarea,
	- actualizează boardul și verifică winner prin `checkWinner()` din `game_logic.dart`,
	- declanșează animații și actualizează scorul,
	- dacă mod == `vsAI` și e rândul AI, cere mișcarea prin `getAIMove()`.

- **`BoardWidget`**: afișează 9 celule; primește `board`, `winningCombo`, `size` și `onTap` callback.

- **`CellWidget`**: afișează simbolul `'X'` sau `'O'` cu animație `ScaleTransition` și efect neon. Dacă simbolul este gol, returnează un `SizedBox.shrink()`.

- **`ConfettiPainter`** (în `lib/widgets/confetti_painter.dart`): `CustomPainter` care desenează particule pentru celebrarea victoriei.

**🧠 AI — cum funcționează**
- *Easy*: alege un index aleator din pozițiile libere.
- *Medium*: verifică prima dacă poate câștiga imediat sau dacă trebuie să blocheze adversarul; altfel alege mutare aleatorie.
- *Hard*: folosește **Minimax** (căutare adversarială completă pentru 3x3) — evaluare +1 pentru victorie AI, -1 pentru victorie jucător, 0 pentru remiză.

Pseudocod Minimax (rezumat):

```text
function minimax(board, player):
	if terminal(board): return score
	for each move in availableMoves:
		apply move
		score = minimax(board, otherPlayer)
		undo move
		choose max/min score based on player
	return bestScore
```

Pentru optimizări: deoarece tabla este foarte mică (9 poziții), Minimax complet este suficient; pentru variante mai mari, adăugați alpha‑beta pruning.

**🔧 Funcții importante (locații)**
- **Verificare câștigător**: `checkWinner(List<String> board)` în [lib/data/game_logic.dart](lib/data/game_logic.dart).
- **Decizie AI**: `getAIMove(List<String> board, AIDifficulty difficulty, Random rand)` în [lib/data/ai.dart](lib/data/ai.dart).
- **Reset/Scor**: `_newGame({bool keepScore = true})` în [lib/screens/home_screen.dart](lib/screens/home_screen.dart).

**🛠 Extindere și sugestii**
- Persistență setări: adaugă `shared_preferences` pentru a salva tema, modul, dificultatea.
- Sunete & animații: folosește `audioplayers` sau `just_audio` și Lottie pentru efecte vizuale de câștig.
- Teste: scrie teste unitare pentru `game_logic.dart` și `ai.dart` (Minimax și cazuri de remiză/victorie).