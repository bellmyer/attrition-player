# Attrition

Attrition is a simple client/server based game to demonstrate how systems 
on a network can collaborate with each other via API calls. If an
[Attrition Player](https://github.com/rubycuts/attrition-player)
is running on the local network, then all you need to do is fire up the game server like so:

    ruby app.rb
    
The game server will seek out any players on the same local network. This takes a few seconds.
Once it's done loading, open a browser to *http://localhost:3100* and click "play" to begin! If
you don't see a player that should be there, just click "reset" and the server will look again
for any late-comers.

Each time you click play, a single round of battle is run. You can do this until there is only
one army remaining. Attrition Server comes with two computer players - one that "bets it all"
every time, and one that sends just a single soldier to each battle.

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

![Attrition](https://github.com/rubycuts/attrition-player/blob/master/public/attrition.png?raw=true)

