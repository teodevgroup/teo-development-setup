echo "Welcome to Teo setup script. This script will clone all Teo repos to the current directory. Make sure you are in the correct directory."

source=GitHub
other_reference=false

# select a source
PS3='Select a source: '
source_options=("GitHub" "Gitee")
select opt in "${source_options[@]}"
do
    case $opt in
        "GitHub")
            source=https://github.com
            source_other=https://gitee.com
            other_name=gitee
            break
            ;;
        "Gitee")
            source=https://gitee.com
            source_other=https://github.com
            other_name=github
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# create other reference
PS3='Create other reference: '
source_options=("True" "False")
select opt in "${source_options[@]}"
do
    case $opt in
        "True")
            other_reference=true
            break
            ;;
        "False")
            other_reference=false
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# read path
read -p "Enter git repo prefix (default \"teodevgroup\"): " prefix

if [ -z "${prefix}" ]; then
    prefix=teodevgroup
fi

echo $source $other_reference $prefix

repos=("teo" "teo-result" "teo-parser" "teo-runtime" "teo-sql-connector" "teo-mongodb-connector" "teo-generator" "teo-nodejs" "teo-python" "teo-vscode" "teo-language-server-wasm" "teo-language-server")

for repo in ${repos[@]}; do
    echo "Clone $source/$prefix/$repo"
    git clone "$source/$prefix/$repo" > /dev/null 2>&1
    
    cd $repo
    if [[ $prefix != teocloud ]]; then
        echo "Setup upstream for $repo"
        git remote add upstream "$source/teocloud/$repo" > /dev/null 2>&1
        git fetch upstream main > /dev/null 2>&1
    fi
    if [[ $other_reference == true ]]; then
        echo "Setup remote $other_name for $repo"
        git remote add $other_name "$source_other/$prefix/$repo" > /dev/null 2>&1
        git fetch $other_name main > /dev/null 2>&1
    fi
    cd ..
    
done

echo "Finish setup! Happy coding!"
