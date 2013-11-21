#!/bin/bash

dir="/usr/share/make-snake/__main__.py"

function breakline
{
   echo -ne "\n"
}

function header
{
   clear
   echo ".-----------------------------------------------------------."
   echo "|  .---._____     ______     ______     ______     _____    |"
   echo "| (  8  ____ \___/ ____ \___/ ____ \___/ ____ \___/ ____\`=- |"
   echo "|  '---'    \_____/    \_____/    \_____/    \_____/        |"
   echo "|   __  __       _            ____              _           |"
   echo "|  |  \/  | __ _| | _____    / ___| _ __   __ _| | _____    |"
   echo "|  | |\/| |/ _\` | |/ / _ \   \___ \| '_ \ / _\` | |/ / _ \   |"
   echo "|  | |  | | (_| |   <  __/    ___) | | | | (_| |   <  __/   |"
   echo "|  |_|  |_|\__,_|_|\_\___|   |____/|_| |_|\__,_|_|\_\___|   |"
   echo "|                                                           |"
   echo "'-----------------------------------------------------------'"
   breakline
   sleep 1
}

function inputLoop
{
   while true; do
      read -e command
      if [ -z "$command" ]; then
         echo "Need to enter a command: '$1' or 'exit'"
      elif [ "$command" == "$1" ] || [ "$command" == "$2" ]; then
         stage=`expr $stage + 1`
         break
      elif [ "$command" == "exit" ]; then
         exit
      fi
      echo "Type '$1' then [ENTER]"
   done
}

# Disable
stty intr undef
stty eof '?'

stage=1

header
if [ "$stage" -le 1 ]; then
   typewriter_echo "Snake is one of the oldest and coolest games." 0 2
   typewriter_echo "Eat apples, but don't bite your tail!" 0 2
   typewriter_echo "Ready to make it?" 0 2
   typewriter_echo "Type 'python snake' then [ENTER]" 0 2
   
   inputLoop 'python snake'
   python -B $dir -m
fi

header
if [ "$stage" -le 2 ]; then
   typewriter_echo "Nice!" 0 2
   typewriter_echo "Want to make the game tougher?" 0 2
   typewriter_echo "'python snake' launches the game. Change it by writing parameters after 'python snake'." 0 2
   typewriter_echo "You can make the board smaller with 'python snake -s m'" 0 2

   inputLoop 'python snake -s m' 'python snake --size m'
   python -B $dir -ms m
fi

header
if [ "$stage" -le 3 ]; then
   typewriter_echo "Another way to increase difficulty is changing the speed" 0 2
   typewriter_echo "Let's try a fast game! 'python snake -v f'" 0 2

   inputLoop 'python snake -v f' 'python snake --velocity f'
   python -B $dir -mv f
fi

header
if [ "$stage" -le 4 ]; then
   typewriter_echo "Awesome! You've changed Snake using computer commands." 0 2
   typewriter_echo "Now try changing its theme (how Snake looks)" 0 2
   typewriter_echo "Type 'python snake -t classic'" 0 2

   inputLoop 'python snake -t classic' 'python snake --theme classic'
   python -B $dir -mt classic
fi

header
if [ "$stage" -le 5 ]; then
   typewriter_echo "You can also use '-t jungle' to play Amazon style!" 0 2

   inputLoop 'python snake -t jungle' 'python snake --theme jungle'
   python -B $dir -mt jungle
fi

header
if [ "$stage" -le 6 ]; then
   typewriter_echo "Use the help option to learn all the different spells." 0 2
   typewriter_echo "Type 'python snake --help' to get help." 0 2

   inputLoop 'python snake --help' 'python snake -h'
   python -B $dir --help
   breakline
   sleep 2
   typewriter_echo "Great! You've completed Make Snake!" 1 2
fi

header
echo "Playground mode!"
typewriter_echo "Try what you have learnt" 0 2
if [ "$stage" -le 6 ]; then
   while true; do
      read -e command
      if [ "$command" == "exit" ]; then
         exit
      fi
      array=($command)
      len="${#array[@]}"
      if [ $len -ge 2 ] && [ ${array[0]} == "python" ] && [ ${array[1]} == "snake" ]; then
          param=""
          space=" "
          for (( index=2; index<$len; index++ )); do
              param=${param}${array[$index]}${space}
          done
          python -B $dir $param
          header
          echo "Playground mode!"
      else
          typewriter_echo "Need help? Type 'python snake --help' or 'exit' to finish" 0 2
      fi
   done
fi
