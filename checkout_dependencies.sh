#!/bin/bash
function checkout_or_update() {
    local repository="${1}"
    local target="${2}"

    if [ -d "${target}" ]; then
        pushd "${target}" 2>&1 >/dev/null
        git reset --hard
        git pull -f
        popd 2>&1 >/dev/null
    else
        git clone "${repository}" "${target}"
    fi
}

pushd "${HOME}" 2>&1 >/dev/null
echo "Installing bash configuration dependencies"
checkout_or_update https://github.com/jakobwesthoff/colorizer.git .colorizer
checkout_or_update https://github.com/jakobwesthoff/prettytable.sh.git .prettytable

echo
echo "Installing r9e-bashrc"
checkout_or_update https://github.com/jakobwesthoff/r9e-bashrc.git .r9e-bashrc

echo
echo "Installing zgen"
checkout_or_update https://github.com/tarjoilija/zgen.git .zgen

echo
echo "Installing solarized dircolors"
checkout_or_update https://github.com/seebi/dircolors-solarized.git .dircolors-solarized
[ ! -f "${HOME}/.dircolors" ] && ln -s "${HOME}/.dircolors-solarized/dircolors.ansi-light" "${HOME}/.dircolors"

echo
echo "Installing nvm"
checkout_or_update https://github.com/creationix/nvm.git .nvm

popd 2>&1 >/dev/null
