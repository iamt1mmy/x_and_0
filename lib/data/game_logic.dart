List<int>? winningComboForBoard(List<String> board, String player) {
  const wins = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  for (var w in wins) {
    if (board[w[0]] == player && board[w[1]] == player && board[w[2]] == player) return w;
  }
  return null;
}

String? checkWinner(List<String> board) {
  final combosX = winningComboForBoard(board, 'X');
  if (combosX != null) return 'X';
  final combosO = winningComboForBoard(board, 'O');
  if (combosO != null) return 'O';
  return null;
}
