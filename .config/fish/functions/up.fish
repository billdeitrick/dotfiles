function up

    argparse --name=up 'h/help' -- $argv
    or return

    if set -q _flag_help;
        echo "Checks whether or not the Internet is reachable."
        echo ""
        echo "Named Arguments/Flags:"
        echo "  -h | --help"
        echo "    Show this help menu."
        return
    end

    if ping -c 2 8.8.8.8 -W 200 | grep "bytes from" > /dev/null
        echo "✅ Yes!"
    else
        echo "❌ No!"
    end
end