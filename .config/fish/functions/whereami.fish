function whereami
    curl -s https://api.ipify.org | xargs echo
end