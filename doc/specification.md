# Qwiz

> 🤓 Get your brain in the game with Qwiz - the ultimate trivia experience! 🧠

## Team 👨‍💻👨‍💻

- Petr Janík (485122)
- Martin Striežovský (485213)

## Technology

Flutter

## Description:

Vědomostní kvíz pro 2 hráče, každý hraje na svém mobilu.
Oba hráči se přihlásí (obrazovka login), poté je to přesměruje do menu, jeden vytvoří novou hru (
obrazovka create game, možnost nastavit počet bodů pro výhru), poté ho to přesměruje do lobby, kde
se zobrazí kód pro druhého hráče. Ten se připojí do hry na svém mobilu pomocí kódu (obrazovka join
game). Hráčům se současně zobrazí otázka a 4 možné odpovědi (obrazovka question). Otázka se vezme z
public API. Oba zároveň odpovídají. Za správnou odpověď dostanou 3 body, pokud oba uhádnou, tak 3 a
2 body podle rychlosti odpovědi. Po každé otázce se obrazí obrazovka s celkovým skóre (obrazovka
result). Pokud mají stejně bodů, následuje otázka na rozstřel. Kdo odpoví až druhý/špatně, ztratí 1
bod. Po dosažení stanoveného počtu bodů jeden hráč vítězí (obrazovka podium).
Propojení hráčů a autentizace se řeší přes Firebase.

## Screen mockups:

- [Login]()
- [Menu]()
- [Create game]()
- [Lobby]()
- [Join game]()
- [Question]()
- [Result]()
- [Podium]()

## Networking:
- Firebase
- [Questions API](https://the-trivia-api.com/)
