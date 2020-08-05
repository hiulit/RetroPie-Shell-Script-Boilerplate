
#!/usr/bin/env bash
# base.sh

# Functions ###########################################

function is_sudo() {
    [[ "$(id -u)" -eq 0 ]]
}


function is_retropie() {
    [[ -d "$home/RetroPie" && -d "$home/.emulationstation" && -d "/opt/retropie" ]]
}


function check_retropie() {
    if ! is_retropie; then
        echo "ERROR: RetroPie is not installed. Aborting ..." >&2
        exit 1
    fi
}


function check_dependencies() {
    [[ -z "$DEPENDENCIES" ]] && return 1

    for pkg in "${DEPENDENCIES[@]}"; do
        if ! dpkg-query -W -f='${Status}' "$pkg" | awk '{print $3}' | grep -q "^installed$"; then
            echo
            echo "WHOOPS! The '$pkg' package is not installed!"
            echo
            echo "Would you like to install it now?"
            local options=("Yes" "No")
            select option in "${options[@]}"; do
                case "$option" in
                    Yes)
                        if ! which apt-get > /dev/null; then
                            echo "ERROR: Can't install '$pkg' automatically. Try to install it manually."
                            exit 1
                        else
                            if sudo apt-get install "$pkg"; then
                                echo
                                echo "YIPPEE! The '$pkg' package installation was successful!"
                            fi
                            break
                        fi
                        ;;
                    No)
                        echo "ERROR: Can't run the script if the '$pkg' package is not installed."
                        exit 1
                        ;;
                    *)
                        echo "Invalid option. Choose a number between 1 and ${#options[@]}."
                        ;;
                esac
            done
        fi
    done
}


function check_argument() {
    # This method doesn't accept arguments starting with a hyphen '-'.
    if [[ -z "$2" || "$2" =~ ^- ]]; then
        echo >&2
        echo "ERROR: '$1' is missing an argument." >&2
        echo >&2
        echo "Try '$0 --help' for more info." >&2
        echo "Or read the documentation in the README." >&2
        echo >&2
        return 1
    fi
}


function underline() {
    local dashes
    local string="$1"
    if [[ -z "$string" ]]; then
        show_error "Missing a string as an argument."
        exit 1
    fi
    echo "$string"
    for ((i=1; i<="${#string}"; i+=1)); do [[ -n "$dashes" ]] && dashes+="-" || dashes="-"; done && echo "$dashes"
}


function usage() {
    echo
    echo "USAGE: $0 [OPTIONS]" # Add 'sudo' before '$0' if the script needs to be run under sudo (e.g. USAGE: sudo $0 [OPTIONS]). Don't change [OPTIONS]! Remember to remove this comment.
    echo
    echo "Use '$0 --help' to see all the options." # Add 'sudo' before '$0' if the script needs to be run under sudo (e.g. Use 'sudo $0 --help' ...). Remember to remove this comment.
}


function show_error() {
    local error_message="$1"

    if [[ -z "$error_message" ]]; then
        echo >&2
        echo "ERROR! '${FUNCNAME[0]}' needs an error message as an argument." >&2
        echo >&2
        underline "Details about the error:" >&2
        echo "- Function:    ${FUNCNAME[0]}" >&2
        echo "- Line:        ${BASH_LINENO[0]}" >&2
        echo "- File:        ${BASH_SOURCE[1]}" >&2
        echo >&2
        exit 1
    fi

    echo >&2
    echo "ERROR! $error_message" >&2
    echo >&2
    underline "Details about the error:" >&2
    echo "- Function:    ${FUNCNAME[1]}" >&2
    echo "- Line:        ${BASH_LINENO[1]}" >&2
    echo "- File:        ${BASH_SOURCE[2]}" >&2
    echo >&2
}
