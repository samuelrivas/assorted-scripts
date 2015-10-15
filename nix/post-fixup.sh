#!/usr/bin/env bash
#
# The scripts that use templates expect the templates to be in the templates
# directory at the same directory the scripts live. This is not very elegant for
# packetising, so we install the templates in the share directory. This step
# rewrites the references to those scripts so that they remain valid.
#
# We also patch some direct calls to binaries so that they point to the store instead
#
# Ideally we should have a less brittle way of configuring assorted scripts, now
# that we can install them

source "$stdenv/setup"

fix_templates_dir () {
    local file="$1"

    substituteInPlace                                       \
        "$file"                                             \
        --replace '$SCRIPT_HOME/assorted-scripts/templates' \
        "$out/share/assorted-scripts/templates"
}

fix_command_call () {
    local file="$1"
    local command="$2"
    local substitution="$3"

    substituteInPlace           \
        "$file"                 \
        --replace "$command"    \
        "$substitution"
}

main() {
    local templated_script;
    local templated_scripts;

    templated_scripts=( $(grep -l templates *.sh) )

    for templated_script in "${templated_scripts[@]}"; do
        echo "patching templates dir in $templated_script"
        fix_templates_dir "$out/bin/$templated_script"
    done

    echo "patching call to xbacklight in screen-control.sh"
    fix_command_call                    \
        "$out/bin/screen-control.sh"    \
        "/usr/bin/xbacklight"           \
        "$xbacklight/bin/xbacklight"

    echo "patching call to xrandr in screen-control.sh"
    fix_command_call "$out/bin/screen-control.sh" "xrandr" "$xrandr/bin/xrandr"

    echo "patching call to xset in screen-control.sh"
    fix_command_call "$out/bin/screen-control.sh" "xset" "$xset/bin/xset"

    echo $PWD
}

main
