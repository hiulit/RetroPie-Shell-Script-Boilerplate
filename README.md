# [SCRIPT_TITLE] (e.g. RetroPie Shell Script Boilerplate)

[SCRIPT_DESCRIPTION] (e.g. A template for building shell scripts for RetroPie.)

## Installation

```bash
cd /home/pi/
git clone [REPOSITORY_URL] (e.g. https://github.com/hiulit/RetroPie-Shell-Script-Boilerplate)
cd [REPOSITORY_NAME]/ (e.g RetroPie-Shell-Script-Boilerplate)
sudo chmod +x [SCRIPT_NAME].sh (e.g. retropie-shell-script-boilerplate)
```

## Usage

```bash
./[SCRIPT_NAME].sh [OPTIONS] (e.g. retropie-shell-script-boilerplate) # Add 'sudo' before './[SCRIPT_NAME].sh' if the script needs to be run under sudo. Remember to remove this comment.
```
If no options are passed, you will be prompted with a usage example:

```bash
USAGE: sudo ./fun-facts-splashscreens.sh [OPTIONS]

Use '--help' to see all the options
```

## Options

```bash
--help: Print the help message and exit.
--option: [OPTION_DESCRIPTION]
```

## Examples

### `--help`

Print the help message and exit.

#### Example

`./[SCRIPT_NAME].sh --help # Add 'sudo' before './[SCRIPT_NAME].sh' if the script needs to be run under sudo. Remember to remove this comment.`

### `--option`

[OPTION_DESCRIPTION]

#### Example

`./[SCRIPT_NAME].sh --option # Add 'sudo' before './[SCRIPT_NAME].sh' if the script needs to be run under sudo. Remember to remove this comment.`
