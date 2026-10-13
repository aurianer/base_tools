#!/bin/bash

set -eux

base_arch=$(uname -m)
echo "Installing for $base_arch"

# fetch <dir> <url> <sha256>: download into <dir> if missing, refuse to continue on a mismatch
fetch() {
    local file
    file="$1/$(basename "$2")"
    [ -f "$file" ] || curl -fL -o "$file" "$2"
    echo "$3  $file" | sha256sum -c - || { echo "checksum mismatch: $file" >&2; exit 1; }
}

# Fd
echo "Installing fd..."
fd_version=10.5.0
fd_dir=fd-v${fd_version}-${base_arch}-unknown-linux-gnu
declare -A fd_sha256=(
    [x86_64]=a1259cd129636efbc3fef123525c1b49e88fe5088c012630983c310e52fdfa95
    [aarch64]=c0ee43802e3313a317c5af2f4eabd6ba13eeedd595af9775f05e18a13ac4f52c
)
mkdir -p fd
fetch fd "https://github.com/sharkdp/fd/releases/download/v${fd_version}/${fd_dir}.tar.gz" \
    "${fd_sha256[$base_arch]}"
pushd fd && tar -xzvf ${fd_dir}.tar.gz && popd
grep -q "fd-v${fd_version}"     ~/.bashrc || echo "export PATH=$PWD/fd/${fd_dir}:\$PATH"   >> ~/.bashrc

# fzf
echo "Installing fzf..."
fzf_version=0.46.1
fzf_dir=fzf-${fzf_version}-linux_${base_arch}
# fzf names its release files by Go architecture; checksums from fzf_0.46.1_checksums.txt
declare -A fzf_goarch=([x86_64]=amd64 [aarch64]=arm64)
declare -A fzf_sha256=(
    [x86_64]=6878dc810c0e464d392985e4e9d3525f7c4af346985f4b094ca117ce1bb0838c
    [aarch64]=cf8896d8dfd51d7a1d184a7db220d3050faa7b508656ed013c905f51be4db09c
)
fzf_file=fzf-${fzf_version}-linux_${fzf_goarch[$base_arch]}.tar.gz
mkdir -p fzf/${fzf_dir}
fetch fzf/${fzf_dir} \
    "https://github.com/junegunn/fzf/releases/download/${fzf_version}/${fzf_file}" \
    "${fzf_sha256[$base_arch]}"
pushd fzf/${fzf_dir} && tar -xzvf ${fzf_file} && popd
grep -q "fzf-${fzf_version}"    ~/.bashrc || echo "export PATH=$PWD/fzf/${fzf_dir}:\$PATH" >> ~/.bashrc
grep -q "fzf/key-bindings.bash" ~/.bashrc || echo "source $PWD/fzf/key-bindings.bash"      >> ~/.bashrc

# direnv
echo "Installing direnv..."
if [[ "$base_arch" == "x86_64" ]]; then
[ ! -f ./direnv/${base_arch}/bin/direnv ] && pushd direnv && ./install.sh && popd
grep -q "direnv/$(uname -m)"    ~/.bashrc || echo "export PATH=$PWD/direnv/${base_arch}/bin:\$PATH" >> ~/.bashrc
grep -q 'eval "$(direnv'        ~/.bashrc || echo 'eval "$(direnv hook bash)"'             >> ~/.bashrc
fi

# activate completions
echo "Activate virtual environments completions..."
grep -q "activate-completion.sh" ~/.bashrc || \
    echo "source \$HOME/config/base_tools/virtual_envs_completion/activate-completion.sh" >> ~/.bashrc

# Alacritty if local install
if [[ -z ${CLUSTER_NAME:-} ]]; then
    ./alacritty/setup.sh
fi
