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
            source=GitHub
            break
            ;;
        "Gitee")
            source=Gitee
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
read -p "Enter git repo prefix (default \"teocloud\"): " prefix

if [ -z "${prefix}" ]; then
    prefix=teocloud
fi

echo $source $other_reference $prefix