functions lsofcmd
    lsof -o0 -o -p (pidof $argv)
