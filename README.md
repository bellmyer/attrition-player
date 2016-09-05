# Attrition

Attrition is a simple client/server based game to demonstrate how systems 
on a network can collaborate with each other via API calls. If the server is
running on the local network, then all you need to do is fire up the client like so:

    ruby app.rb
    
Of course, if you want the game to be interesting, you'll modify the Player class first,
which can be found in `lib/player.rb`. In order to do that, you'll need to understand the
rules of the game.

## The Rules of Attrition

A war of attrition is a war where two or more armies are just wearing down each other's
resources until all but one side is exhausted. This strategy game illustrates that. It
has just a few simple principles:

### 1. Armies Decide How Many Soldiers to "Wager" in Battle

Each Army Begins the game with 100 Soldiers. For each battle, the general must decide how many
soldiers to send - at least one. The general only knows the total size of each of the other armies, but
not how many soldiers the other armies plan to send into battle.

### 2. Losses are Equal on All Sides

A battle ensues until only one army is still standing. Assume Side A sends 5 soldiers 
to battle, and Side B sends 3. With equal losses, Side A will end up with 2 soldiers, 
and Side B will end up with none. 

This is only slightly more complicated with multiple armies. If three armies send 10, 5, 
and 3 soldiers, then the largest army will end up with 5 soldiers remaining, and the other
two will end up with none.

### 3. Winning Armies Earn a Bonus

The winning army earns "bonus" soldiers based on how many fighting soldiers it still has
at the end of a battle. It gets to claim that many soldiers from each of the losing armies.
Of course, it can't claim more soldiers than an army sent into battle in the first place.

So in our example above, the winning army has 5 remaining soldiers. It earns a bonus of 5 
soldiers from the army that sent 5, and only 3 from the army that just sent 3. A total of 13 
soldiers return from battle to the winning army. 

Added to the 90 soldiers that didn't fight, the winning army now has 103 soldiers. The other
two armies are down the number of soldiers they sent to battle, so they have 95 and 98 soldiers,
respectively.

### 4. Be the Last Army Standing

The game is played round after round, until only a single army is still standing. The
scoreboard ranks players based on how many overall battles they survived before running
out of soldiers.

## Strategy

As you can see, if you're going to win, you need to win big even to just maintain the same 
army size. If you KNEW you were going to lose, you'd want to lose as few soldiers as possible.
Herein lies the strategy - the worst thing you can do is win small or lose big.

## The Player Class

Here is the Player class you must modify in order to implement YOUR strategy:

    # lib/player.rb
    class Player
      def name
        'Default Player'
      end
  
      def move armies, soldiers
        soldiers / 2
      end
    end

The player class is simple, and only has two public methods: `name` and `move`. The `name` method 
just reports the name of this player back to the server so you can recognize your player on
the scoreboard.

The `move` method accepts two parameters: an array of army sizes, and the number of soldiers YOUR
army currently contains after the latest battle. Based on this information, you must return 
the number of soldiers you wish to wager in the next battle. 

The array of army sizes will always be in the same order, so you can track each army's progress
over time. All army sizes will be given, even for armies who have run out of soldiers, and are
therefore eliminated from the game.

The default player ignores the sizes of other armies, and just wagers half its soldiers every time.
**HINT:** This is probably the worst possible strategy, so you can only improve from here!

## Testing

For testing purposes, you may wish to download and run the
[Attrition Server](https://github.com/rubycuts/attrition-server)
in a separate terminal window. It comes with two computer players; "Bet It All" wagers everything
every time, and "Play it Safe" wagers just one soldier per battle. Fire up your own player first,
and THEN start the server. This is necessary because the server will seek out all players on the 
network. Then visit "http://localhost:3100" to play the game:

![Attrition](https://github.com/rubycuts/attrition-server/blob/master/public/attrition.png?raw=true)

