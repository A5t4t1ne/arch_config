function pl --wraps='netstat -lpnt' --description 'alias pl=netstat -lpnt'
  netstat -lpnt $argv
        
end
