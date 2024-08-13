#/bin/bash

if [[ -z $CLUSTER_NAME ]]; then
    dir_=$HOME/virtual_envs
else
    dir_=$SCRATCH/virtual_envs
fi

pushd $dir_ > /dev/null
list_of_suggestions=($(find . -mindepth 1 -maxdepth 1))
popd > /dev/null
filtered_list=${list_of_suggestions[@]#"./"}

complete -W "$(echo ${filtered_list[@]})" activate
