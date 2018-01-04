#!/usr/bin/env bash

# Retropie Shell Script Boilerplate.
# A template for building shell scripts for RetroPie.
#
# Requirements:
# - RetroPie x.x.x (e.g. RetroPie 4.x.x)
# - [NAME_OF_THE_PACKAGE] package (e.g. libav-tools package)

home="$(find /home -type d -name RetroPie -print -quit 2>/dev/null)"
home="${home%/RetroPie}"

readonly SCRIPT_TITLE=""
readonly SCRIPT_DESCRIPTION=""
readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

function is_retropie() {
    [[ -d "$home/RetroPie" && -d "$home/.emulationstation" && -d "/opt/retropie" ]]
}

function check_dependencies() {
    if ! which [COMMAND_TO_TEST] > /dev/null; then # (e.g if ! which git > /dev/null)
        echo "ERROR: The [NAME_OF_THE_PACKAGE] package is not installed!" >&2 # (e.g. git)
        echo "Please, install it with 'sudo apt-get install [NAME_OF_THE_PACKAGE]'." >&2 # (e.g. git)
        exit 1
    fi
}

function check_argument() {
    # This method doesn't accept arguments starting with '-'.
    if [[ -z "$2" || "$2" =~ ^- ]]; then
        echo >&2
        echo "ERROR: '$1' is missing an argument." >&2
        echo >&2
        echo "Try '$0 --help' for more info." >&2
        echo >&2
        return 1
    fi
}

function usage() {
    echo
    echo "USAGE: $0 [options]"
    echo
    echo "Use '--help' to see all the options."
    echo
}

# Add your own functions here.

# You can add as many options as you want.
# To add a new option, copy and paste from '#H -o, --option ...' until ';;'
function get_options() {
    if [[ -z "$1" ]]; then
        usage
        exit 0
    fi

    while [[ -n "$1" ]]; do
        case "$1" in
#H -h, --help                                   Print the help message and exit.
            -h|--help)
                echo
                echo "$SCRIPT_TITLE"
                echo "$SCRIPT_DESCRIPTION"
                echo
                echo "USAGE: $0 [options]"
                echo
                echo "OPTIONS:"
                echo
                sed '/^#H /!d; s/^#H //' "$0" # Prints all the options.
                echo
                exit 0
                ;;

#H -o, --option (e.g '-v, --version')       Description of the option (e.g. Show version of the script).       
            -o|--option)
                # If the option has argument, uncomment the code below. If not, just delete it.
                # check_argument "$1" "$2" || exit 1
                # shift
                
                # Add the functions for this options here.
                ;;        
            *)
                echo "ERROR: invalid option \"$1\"" >&2
                exit 2
                ;;
        esac
        shift
    done
}

function main() {
    check_dependencies

    if ! is_retropie; then
        echo "ERROR: RetroPie is not installed. Aborting ..." >&2
        exit 1
    fi

    get_options "$@"
}

main "$@"
