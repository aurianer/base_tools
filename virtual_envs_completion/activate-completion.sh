#/bin/bash

if [[ -z $CLUSTER_NAME ]]; then
    dir=$HOME/virtual_envs
else
    dir=$SCRATCH/virtual_envs
fi

if [[ -d $dir ]]; then
    pushd $SCRATCH/virtual_envs > /dev/null
        list_of_suggestions=($(find . -mindepth 1 -maxdepth 1))
    popd > /dev/null

    filtered_list=${list_of_suggestions[@]#"./"}
    complete -W "$(echo ${filtered_list[@]})" activate
fi
