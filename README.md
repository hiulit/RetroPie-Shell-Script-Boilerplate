# [SCRIPT_TITLE] (e.g. RetroPie Shell Script Boilerplate)

[SCRIPT_DESCRIPTION] (e.g. A template for building shell scripts for RetroPie.)

## Installation

```
cd /home/pi/
git clone [REPOSITORY_URL] (e.g. https://github.com/hiulit/RetroPie-Shell-Script-Boilerplate)
cd [REPOSITORY_NAME]/ (e.g RetroPie-Shell-Script-Boilerplate)
sudo chmod +x [SCRIPT_NAME].sh (e.g. retropie-shell-script-boilerplate)
```

## Usage

```
./[SCRIPT_NAME].sh [OPTIONS] (e.g. retropie-shell-script-boilerplate) # Add 'sudo' before './[SCRIPT_NAME].sh' if the script needs to be run under sudo. Don't change [OPTIONS]! Remember to remove this comment.
```
If no options are passed, you will be prompted with a usage example:

```
USAGE: sudo ./[SCRIPT_NAME].sh [OPTIONS] (e.g. retropie-shell-script-boilerplate) # Don't change [OPTIONS]! Remember to remove this comment.

Use '--help' to see all the options.
```

## Options

```
--help: Print the help message and exit.
--[OPTION]: [OPTION_DESCRIPTION] (e.g --version: Show script version.)
```

## Examples

### `--help`

Print the help message and exit.

#### Example

`./[SCRIPT_NAME].sh --help (e.g. retropie-shell-script-boilerplate) # Add 'sudo' before './[SCRIPT_NAME].sh' if the script needs to be run under sudo. Remember to remove this comment.`

### `--[OPTION]`

[OPTION_DESCRIPTION]

#### Example

`./[SCRIPT_NAME].sh --[OPTION] (e.g. retropie-shell-script-boilerplate) # Add 'sudo' before './[SCRIPT_NAME].sh' if the script needs to be run under sudo. Remember to remove this comment.`

## Config file

[CONFIG_FILE_DESCRIPTION]

```
# Settings for [SCRIPT_TITLE] (e.g. RetroPie Shell Script Boilerplate)

# Add your own [key = "value"] (e.g. path_to_whatever = "/path/to/whatever")
# [KEY] WITHOUT quotes.
# [VALUE] WITH quotes.
# There MUST be 1 space before and after '='.
# To indicate that a [KEY] has NO [VALUE] or is NOT SET, just leave the quotes, like this: "".

# Description of the [key = "value"] (e.g. # Set path to whatever).
[KEY] = "[VALUE]"

# Add your own [key = "value"]
```

## Changelog

See [CHANGELOG](/CHANGELOG.md).

## Contributing

See [CONTRIBUTING](/CONTRIBUTING.md).

## Authors

* Yourself
* Another person.

## Credits

Thanks to:

* This person.
* This other person.

## License

[[LICENSE]](/LICENSE). (e.g. MIT License)
