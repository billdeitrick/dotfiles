function rider
    if test -e "/Applications/Rider EAP.app"
        open -na "Rider EAP.app" $argv[1]
    else
        open -na "Rider.app" $argv[1]
    end
end