#/bin/bash

if [ -z $CLUSTER_NAME ]; then
    # Local
    _dir=$SCRATCH/virtual_envs/$(uname -m)
else
    _dir=$HOME/virtual_envs/
fi
pushd $_dir > /dev/null
    list_of_suggestions=($(find . -mindepth 1 -maxdepth 1))
popd > /dev/null
filtered_list=${list_of_suggestions[@]#"./"}

complete -W "$(echo ${filtered_list[@]})" activate
