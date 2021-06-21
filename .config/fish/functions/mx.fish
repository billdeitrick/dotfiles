function mx

    argparse --ignore-unknown --name=mx 'h/help' 'd/domain=' -- $argv
    or return

    if set -q _flag_help;
        echo "Get the mx records for a domain."
        echo ""
        echo "You must specify domain as either name or positional argument."
        echo ""
        echo "Positional Arguments:"
        echo "  domain"
        echo "    The domain for which records should be retrieved."
        echo ""
        echo "Named Arguments/Flags:"
        echo "  -d | --domain"
        echo "    The domain for which records should be retrieved."
        echo "  -h | --help"
        echo "    Show this help menu."
        return
    end

    if set -q _flag_domain
        set domain $_flag_domain
    else if count $argv > /dev/null
        set domain $argv[1]
    else
        echo 'Required argument "domain" not present.'
    end

    nslookup -type=mx $domain | tail -n +4

end