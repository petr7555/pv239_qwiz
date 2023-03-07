# Qwiz

> 🤓 Get your brain in the game with Qwiz - the ultimate trivia experience! 🧠

## Team 👨‍💻👨‍💻

- Petr Janík (485122)
- Martin Striežovský (485213)

## Technology

Flutter

## Description:

_**Qwiz**_ is a knowledge game for two players, each playing on their mobile.
Both players log in using Google authentication (**login** screen),
and then they are redirected to the **menu**.
One player creates a new game (**create game** screen). Here a number of points required for winning
is set.
Then the player moves to the **lobby** where a code for the other player is displayed.
The second player joins the game on their mobile using the code (**join game** screen).
Both players are presented with a question and 4 possible answers (**question** screen).
The question is taken from a public API and is the same for both players.
They are both answering at the same time. There is a timeout of 10 sec for the question visualized
by a progress bar. If they both answer, the timeout ends immediately.
If they both answer correctly, the one who answered sooner gets 3 points,
the other one gets 2 points.
If only one of them answered correctly, they get 3 points. If no player answered correctly,
no points are given. There are no negative points. They players might not answer at all.
After each question, a screen with players' current score is displayed (**result** screen).
If they have the same score, a shootout question follows.
Whoever answers second/wrong loses 1 point. There are no positive points given.
The minimal score at any time is 0.
When one of the players reaches the set number of points, they win. The **podium** screen is shown.
Players can see a history of games they participated in (**history** screen).
For each such game, they cee their score, the score of their opponent and the winner.
They can also see the questions with the options, the correct answer, their answer and the
opponent's answer. The history is sorted by date, the most recent game is at the top.
There will be a leaderboard of all players (**leaderboard** screen) sorted by the total number of
points obtained in all games. The player can see their position in the leaderboard and the number of
points they have. Each user has a profile picture and a name. These are taken from the Google
account they've logged in with.

## Screen mockups:

- [Login]()
- [Menu]()
- [Create game]()
- [Lobby]()
- [Join game]()
- [Question]()
- [Result]()
- [Podium]()
- [History]()
- [Leaderboard]()

## Networking:

- Firebase
- [Questions API](https://the-trivia-api.com/)
