function nr -d "Create a new directory, enter and create git repo."
    command mkdir $argv
    if test $status = 0
        cd $argv
        command git init
    end
end