echo "Welcome to Teo update script. This script will update all repos."

repos=("teo" "teo-result" "teo-teon" "teo-parser" "teo-runtime" "teo-sql-connector" "teo-mongodb-connector" "teo-generator" "teo-nodejs" "teo-python" "teo-vscode" "teo-language-server-wasm" "teo-language-server")
for repo in ${repos[@]}; do
    cd $repo
    git pull origin main > /dev/null 2>&1
    if git ls-remote --exit-code upstream; then
        git fetch upstream main > /dev/null 2>&1
        read -p "Merge upstream and push to origin? " -n 1 -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            git merge upstream
            git push origin
        fi    
    fi
    cd ..
done

echo "Finish update! Happy coding!"