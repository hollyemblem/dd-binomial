## Loading relevant libraries
library(dplyr)
library(Rdice)

## Setting died variable
died <- "You have died! Input startgame() to try again"

## Main function which handles game play
startGame <- function()
{
  
  
  print("Brave adventurer, you truly need a miracle to save your band of unlikely heroes! The odds are against you, the Tarrasque is at the door! As well as a lot of stirges. You must roll three twenties out of four total rolls in order to survive. Do you accept the task? Enter 'yes' to continue."
  )
  
  value <- yesNo()
  
  response <- if(grepl("y",value,ignore.case = TRUE)){
    print("Excellent news! We shall proceed, brave adventurer.")
    actionRoll()
  }
  
  else{
    continue <- 0
    print("Oh dear. Well I didn't expect you to give up before we even started with the rolls. This is awkward. Guess I'll just let the Tarrasque in?")  
    print(died)
  }
  
}

## Function which handles the dice rolls
actionRoll <- function(){
  diceRolls <- c()
  
  for(i in 1:4){
    if( i == 1){
      print("You must roll three twenties out of four total rolls, else the Tarrasque will kill your merry band of adventurers!")
    }
    print("The dungeon master hands you the twenty-sided die. Enter 'roll' to roll the dice")
    rollValue <- rollDieConfirm()
    
    responseRoll <- if(grepl("roll",rollValue,ignore.case = TRUE)){
      print("You roll the dice. With baited breath, you await the result...")
      Sys.sleep(2)
      diceValue <- dice.roll(20, 1, 1,)
      diceValue <- diceValue$results$values
      print(paste("You rolled a",diceValue, sep=" "))
      diceRolls <- c(diceValue,diceRolls)  
    }
  }
  evaluator(diceRolls)
}


## Function prompting user to proceed
yesNo <- function()
{
  n <- readline(prompt="Do you accept the challenge? Enter 'y' to proceed")
  return(n)
}

##Function prompting user to roll dice
rollDieConfirm <- function()
{
  n <- readline(prompt="Enter 'roll' to proceed")
  return(n)
}


## Function deciding the fate of adventurers
evaluator <- function(x){
  counter <- length(which(x == 20)) 
  print("Adventurer, you rolled the following")
  print(x)
  if(counter > 2){
    print("Hooray! While the odds were against you, you have managed to defeat the Tarrasque. Want to play again? Enter startGame()")
  }
  else{
    print(paste("Unfortunately, while you fought well, the Tarrasque was too strong, and you were not able to defeat it.",died, sep = " "))
  }
}