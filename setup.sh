#!/bin/bash

set -eux

base_arch=$(uname -m)
echo "Installing for $base_arch"

# Fd
echo "Installing fd..."
fd_version=8.7.1
fd_dir=fd-v${fd_version}-${base_arch}-unknown-linux-gnu
pushd fd && tar -xzvf ${fd_dir}.tar.gz && popd
grep -q "fd-v${fd_version}"     ~/.bashrc || echo "export PATH=$PWD/fd/${fd_dir}:\$PATH"   >> ~/.bashrc

# fzf
echo "Installing fzf..."
fzf_version=0.46.1
fzf_dir=fzf-${fzf_version}-linux_${fzf_arch}
pushd fzf/${fzf_dir} && tar -xzvf ${fzf_dir}.tar.gz && popd
grep -q "fzf-${fzf_version}"    ~/.bashrc || echo "export PATH=$PWD/fzf/${fzf_dir}:\$PATH" >> ~/.bashrc
grep -q "fzf/key-bindings.bash" ~/.bashrc || echo "source $PWD/fzf/key-bindings.bash"      >> ~/.bashrc

# direnv
echo "Installing direnv..."
if [[ "$base_arch" == "x86_64" ]]; then
[ ! -f ./direnv/${base_arch}/bin/direnv ] && pushd direnv && ./install.sh && popd
grep -q "direnv/$(uname -m)"    ~/.bashrc || echo "export PATH=$PWD/direnv/${base_arch}/bin:\$PATH" >> ~/.bashrc
grep -q 'eval "$(direnv'        ~/.bashrc || echo 'eval "$(direnv hook bash)"'             >> ~/.bashrc

# activate completions
echo "Activate virtual environments completions..."
grep -q "activate-completion.sh" ~/.bashrc || \
    echo "source \$HOME/config/base_tools/virtual_envs_completion/activate-completion.sh" >> ~/.bashrc

# Alacritty if local install
if [[ -z $CLUSTER_NAME ]]; then
    ./alacritty/setup.sh
fi
