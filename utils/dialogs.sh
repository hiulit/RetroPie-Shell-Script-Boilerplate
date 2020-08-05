#!/usr/bin/env bash
# dialogs.sh

# Variables ############################################

DIALOG_BACKTITLE="$SCRIPT_TITLE (v$SCRIPT_VERSION)" # Change this text to your liking.

readonly DIALOG_HEIGHT=20 # Change this value to your liking.
readonly DIALOG_WIDTH=60 # Change this value to your liking.

# Exit status
readonly DIALOG_OK=0
readonly DIALOG_CANCEL=1
readonly DIALOG_HELP=2
readonly DIALOG_EXTRA=3
readonly DIALOG_ESC=255


# Functions ###########################################

function show_dialog_example() {
    local dialog="${FUNCNAME[1]}"
    echo
    underline "Example of usage ($dialog):"
    case "$dialog" in
       "dialog_infobox")
            echo 'dialog_infobox "title" "message" ["height" "width"]'
            echo
            echo '"title" can be left empty, like this: "".'
            ;;
       "dialog_yesno")
            echo 'dialog_yesno "title" "message" ["height" "width"]'
            echo
            echo '"title" can be left empty, like this: "".'
            ;;
       "dialog_msgbox")
            echo 'dialog_msgbox "title" "message" ["height" "width"]'
            echo
            echo '"title" can be left empty, like this: "".'
            ;;
        "dialog_menu")
            echo 'options=('
            echo '  "1" "Option 1" #"Help message 1"'
            echo '  "2" "Option 2" #"Help message 2"'
            echo '  "N" "Option N" #"Help message N"'
            echo ')'
            echo
            echo 'dialog_menu [-h/b] "Text describing the options." "${options[@]}"'
            echo
            echo '-h: Add help messages.'
            echo '-b: Add back button.'
            ;;
        *)
            echo "There is no example for this dialog."
            ;;
    esac
    echo
}


# Dialogs #############################################

# An info dialog box.
#
# Example
# -------
# dialog_infobox "title" "message" ["height" "width"]
#
# "title" can be left empty, like this: "".
#
function dialog_infobox() {
    local title="$1"
    local message="$2"
    local dialog_height="$3"
    local dialog_width="$4"

    if [[ -z "$message" ]]; then
        show_error "'${FUNCNAME[0]}' needs a \"message\" as an argument!"
        show_dialog_example
        exit 1
    fi
    [[ -z "$dialog_height" ]] && dialog_height=8 # Change this value to your liking.
    [[ -z "$dialog_width" ]] && dialog_width="$DIALOG_WIDTH"

    dialog \
        --backtitle "$DIALOG_BACKTITLE" \
        --title "$title" \
        --infobox "$message" "$dialog_height" "$dialog_width" 2>&1 >/dev/tty
}


# A message dialog box.
#
# Example
# -------
# dialog_msgbox "title" "message" ["height" "width"]
#
# "title" can be left empty, like this: "".
#
function dialog_msgbox() {
    local title="$1"
    local message="$2"
    local dialog_height="$3"
    local dialog_width="$4"

    if [[ -z "$message" ]]; then
        show_error "'${FUNCNAME[0]}' needs a \"message\" as an argument!"
        show_dialog_example
        exit 1
    fi

    [[ -z "$dialog_height" ]] && dialog_height=8 # Change this value to your liking.
    [[ -z "$dialog_width" ]] && dialog_width="$DIALOG_WIDTH"

    dialog \
        --backtitle "$DIALOG_BACKTITLE" \
        --title "$title" \
        --ok-label "OK" \
        --msgbox "$message" "$dialog_height" "$dialog_width" 2>&1 >/dev/tty
}


# A yes/no dialog box.
#
# Example
# -------
# dialog_yesno "title" "message" ["height" "width"]
#
# "title" can be left empty, like this: "".
#
function dialog_yesno() {
    local title="$1"
    local message="$2"
    local dialog_height="$3"
    local dialog_width="$4"

    if [[ -z "$message" ]]; then
        show_error "'${FUNCNAME[0]}' needs a \"message\" as an argument!"
        show_dialog_example
        exit 1
    fi

    [[ -z "$dialog_height" ]] && dialog_height=8 # Change this value to your liking.
    [[ -z "$dialog_width" ]] && dialog_width="$DIALOG_WIDTH"

    dialog \
        --backtitle "$DIALOG_BACKTITLE" \
        --title "$title" \
        --yes-label "Yes" \
        --no-label "No" \
        --yesno "$message" "$dialog_height" "$dialog_width" 2>&1 >/dev/tty
}


# A menu dialog box.
#
# Example
# -------
# options=(
#     "1" "Option 1" #"Help message 1"
#     "2" "Option 2" #"Help message 2"
#     "N" "Option N" #"Help message N"
# )
#
# dialog_menu [-h/b] "Text describing the options." "${options[@]}"
#
# -h: Add help messages.
# -b: Add back button.
#
function dialog_menu() {
    local BACK=0
    local HELP=0

    # Check if the first argument starts with a hypen '-'.
    if [[ "$1" =~ ^-.* ]]; then
        if [[ "$1" =~ "b" ]]; then
            BACK=1
        fi
        if [[ "$1" =~ "h" ]]; then
            HELP=1
        fi
        shift
    fi

    local description_text="$1"
    shift

    # Get the options passed as arguments.
    local argument_options=("$@")
    if [[ -z "$argument_options" ]]; then
        show_error "\"options\" is empty."
        show_dialog_example
        exit 1
    fi
    # Create a new options array.
    local options=()
    local option
    # Rebuild the options array with the arguments.
    for option in "${argument_options[@]}"; do
        options+=("$option")
    done

    local cmd
    local choice

    cmd=(dialog \
        --backtitle "$DIALOG_BACKTITLE" \
        --title "$SCRIPT_TITLE" \
        --ok-label "OK" \
        --cancel-label "Exit" \
        --menu "$description_text\n\nChoose an option." "$DIALOG_HEIGHT" "$DIALOG_WIDTH" "$((${#options[@]} / 2))")

    if [[ "$BACK" -eq 1 ]]; then
        # Insert the back button properties just before '--menu'.
        cmd=("${cmd[@]:0:9}" "--extra-button" "${cmd[@]:9}")
        cmd=("${cmd[@]:0:10}" "--extra-label" "${cmd[@]:10}")
        cmd=("${cmd[@]:0:11}" "Back" "${cmd[@]:11}")
    fi

    if [[ "$HELP" -eq 1 ]]; then
        # The options number must be divisible by 3.
        if (( "${#options[@]}" % 3 != 0 )); then
            show_error "There's at least 1 help message missing on the options passed."
            exit 1
        fi
        # Check if the back button is enabled to
        # modify the index position of the help dialog property.
        local index_position=9
        if [[ "$BACK" -eq 1  ]]; then
            index_position=12
        fi
        # Insert '--item-help' just before '--menu'.
        cmd=("${cmd[@]:0:$index_position}" "--item-help" "${cmd[@]:$index_position}")
        # Adjust the menu height.
        local last_array_element="$((${#cmd[@]} - 1))"
        cmd["$last_array_element"]="$((${#options[@]} / 3))"
    else
        # The options number must be divisible by 2.
        if (( "${#options[@]}" % 2 != 0 )); then
            show_error "It seems like there are help messages passed but the '-h' argument is missing."
            exit 1
        fi
    fi

    choice="$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)"
    local return_value="$?"

    # "OK" button.
    if [[ "$return_value" -eq "$DIALOG_OK" ]]; then
        if [[ -n "$choice" ]]; then
            # Add as many cases as options.
            case "$choice" in
                "1")
                    # Call some function or do something.
                    echo "You chose 'Option "$choice"'."
                    ;;
                "2")
                    # Call some function or do something.
                    echo "You chose 'Option "$choice"'."
                    ;;
                "N")
                    # Call some function or do something.
                    echo "You chose 'Option "$choice"'."
                    ;;
            esac
        else
            dialog_msgbox "Error!" "Choose an option."
        fi
    # "BACK" button.
    elif [[ "$return_value" -eq "$DIALOG_EXTRA" ]]; then
        # Call the previous dialog box.
        # Example: i_am_the_previous_dialog
        # Remove the 'exit 0' line below. It's only here for test purposes.
        exit 0
    # "EXIT" button.
    elif [[ "$return_value" -eq "$DIALOG_CANCEL" ]]; then
        # Exit the dialog box.
        exit 0
    fi
}
