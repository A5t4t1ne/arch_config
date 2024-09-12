function pipes --wraps='pipes.sh -t 3 -p 10 -r 3000' --wraps='pipes.sh -t 3 -p 10 -r 5000' --description 'alias pipes=pipes.sh -t 3 -p 10 -r 5000'
  pipes.sh -t 3 -p 10 -r 10000 $argv
end
