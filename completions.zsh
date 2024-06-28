
> palm@0.0.1 tauri
> tauri completions --shell zsh

#compdef cargo

autoload -U is-at-least

_cargo() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_cargo_commands" \
"*::: :->cargo" \
&& ret=0
    case $state in
    (cargo)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'--runner=[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[Space or comma separated list of features to activate]' \
'*--features=[Space or comma separated list of features to activate]' \
'*-b+[Space or comma separated list of bundles to package]' \
'*--bundles=[Space or comma separated list of bundles to package]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'-d[Builds with the debug flag]' \
'--debug[Builds with the debug flag]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments:' \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to run the application]:RUNNER: ' \
'--runner=[Binary to use to run the application]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[List of cargo features to activate]' \
'*--features=[List of cargo features to activate]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--port=[Specify port for the dev server for static files. Defaults to 1430 Can also be set using \`TAURI_DEV_SERVER_PORT\` env var]:PORT: ' \
'-e[Exit on panic]' \
'--exit-on-panic[Exit on panic]' \
'--release[Run the code in release mode]' \
'--no-watch[Disable the file watcher]' \
'--no-dev-server[Disable the dev server for static files]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments. Arguments after a second `--` are passed to the application e.g. `tauri dev -- \[runnerArgs\] -- \[appArgs\]`:' \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
'-o+[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'--output=[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'*-p+[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*--png=[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::input -- Path to the source icon (png, 1024x1024px with transparency):_files' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
'--interactive[Interactive mode to apply automatic fixes]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-A+[Name of your Tauri application]:APP_NAME: ' \
'--app-name=[Name of your Tauri application]:APP_NAME: ' \
'-W+[Window title of your Tauri application]:WINDOW_TITLE: ' \
'--window-title=[Window title of your Tauri application]:WINDOW_TITLE: ' \
'-D+[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'--dist-dir=[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'-P+[Url of your dev server]:DEV_PATH: ' \
'--dev-path=[Url of your dev server]:DEV_PATH: ' \
'--before-dev-command=[A shell command to run before \`tauri dev\` kicks in]:BEFORE_DEV_COMMAND: ' \
'--before-build-command=[A shell command to run before \`tauri build\` kicks in]:BEFORE_BUILD_COMMAND: ' \
'--ci[Skip prompting for values]' \
'-f[Force init to overwrite the src-tauri folder]' \
'--force[Force init to overwrite the src-tauri folder]' \
'-l[Enables logging]' \
'--log[Enables logging]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
'-n+[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'--name=[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-a+[Author name]:AUTHOR: ' \
'--author=[Author name]:AUTHOR: ' \
'--api[Initializes a Tauri plugin with TypeScript API]' \
'--tauri[Initializes a Tauri core plugin (internal usage)]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__plugin__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-help-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
'(-f --private-key-path)-k+[Load the private key from a string]:PRIVATE_KEY: ' \
'(-f --private-key-path)--private-key=[Load the private key from a string]:PRIVATE_KEY: ' \
'(-k --private-key)-f+[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'(-k --private-key)--private-key-path=[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':file -- Sign the specified file:_files' \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'-w+[Write private key to a file]:WRITE_KEYS:_files' \
'--write-keys=[Write private key to a file]:WRITE_KEYS:_files' \
'-f[Overwrite private key even if it exists on the specified path]' \
'--force[Overwrite private key even if it exists on the specified path]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__signer__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-help-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-s+[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'-o+[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'--output=[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_cargo__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-help-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
":: :_cargo__help__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-help-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_cargo__help__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-help-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_cargo__help__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-help-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_cargo_commands] )) ||
_cargo_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__build_commands] )) ||
_cargo__help__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__build_commands] )) ||
_npm__run__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__build_commands] )) ||
_npm__run__tauri__help__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help build commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__completions_commands] )) ||
_cargo__help__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__completions_commands] )) ||
_npm__run__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__completions_commands] )) ||
_npm__run__tauri__help__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help completions commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__dev_commands] )) ||
_cargo__help__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__dev_commands] )) ||
_npm__run__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__dev_commands] )) ||
_npm__run__tauri__help__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help dev commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__signer__generate_commands] )) ||
_cargo__help__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__generate_commands] )) ||
_npm__run__tauri__help__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__generate_commands] )) ||
_npm__run__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__generate_commands] )) ||
_npm__run__tauri__signer__help__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help generate commands' commands "$@"
}
(( $+functions[_cargo__help_commands] )) ||
_cargo__help_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo help commands' commands "$@"
}
(( $+functions[_cargo__help__help_commands] )) ||
_cargo__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help_commands] )) ||
_npm__run__tauri__help_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__help_commands] )) ||
_npm__run__tauri__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help_commands] )) ||
_npm__run__tauri__plugin__help_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__help_commands] )) ||
_npm__run__tauri__plugin__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help_commands] )) ||
_npm__run__tauri__signer__help_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__help_commands] )) ||
_npm__run__tauri__signer__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help help commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__icon_commands] )) ||
_cargo__help__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__icon_commands] )) ||
_npm__run__tauri__help__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__icon_commands] )) ||
_npm__run__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri icon commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__info_commands] )) ||
_cargo__help__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__info_commands] )) ||
_npm__run__tauri__help__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__info_commands] )) ||
_npm__run__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri info commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__init_commands] )) ||
_cargo__help__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri init commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__plugin__init_commands] )) ||
_cargo__help__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__init_commands] )) ||
_npm__run__tauri__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin__init_commands] )) ||
_npm__run__tauri__help__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__init_commands] )) ||
_npm__run__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__init_commands] )) ||
_npm__run__tauri__plugin__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__init_commands] )) ||
_npm__run__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin init commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__plugin_commands] )) ||
_cargo__help__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'cargo help tauri plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin_commands] )) ||
_npm__run__tauri__help__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'npm run tauri help plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin_commands] )) ||
_npm__run__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__signer__sign_commands] )) ||
_cargo__help__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'cargo help tauri signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__sign_commands] )) ||
_npm__run__tauri__help__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__sign_commands] )) ||
_npm__run__tauri__signer__help__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__sign_commands] )) ||
_npm__run__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer sign commands' commands "$@"
}
(( $+functions[_cargo__help__tauri__signer_commands] )) ||
_cargo__help__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'cargo help tauri signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer_commands] )) ||
_npm__run__tauri__help__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'npm run tauri help signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer_commands] )) ||
_npm__run__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer commands' commands "$@"
}
(( $+functions[_cargo__help__tauri_commands] )) ||
_cargo__help__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
    )
    _describe -t commands 'cargo help tauri commands' commands "$@"
}
(( $+functions[_npm__run__tauri_commands] )) ||
_npm__run__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri commands' commands "$@"
}

if [ "$funcstack[1]" = "_cargo" ]; then
    _cargo "$@"
else
    compdef _cargo cargo
fi

#compdef pnpm

autoload -U is-at-least

_pnpm() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_pnpm_commands" \
"*::: :->pnpm" \
&& ret=0
    case $state in
    (pnpm)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pnpm-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'--runner=[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[Space or comma separated list of features to activate]' \
'*--features=[Space or comma separated list of features to activate]' \
'*-b+[Space or comma separated list of bundles to package]' \
'*--bundles=[Space or comma separated list of bundles to package]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'-d[Builds with the debug flag]' \
'--debug[Builds with the debug flag]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments:' \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to run the application]:RUNNER: ' \
'--runner=[Binary to use to run the application]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[List of cargo features to activate]' \
'*--features=[List of cargo features to activate]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--port=[Specify port for the dev server for static files. Defaults to 1430 Can also be set using \`TAURI_DEV_SERVER_PORT\` env var]:PORT: ' \
'-e[Exit on panic]' \
'--exit-on-panic[Exit on panic]' \
'--release[Run the code in release mode]' \
'--no-watch[Disable the file watcher]' \
'--no-dev-server[Disable the dev server for static files]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments. Arguments after a second `--` are passed to the application e.g. `tauri dev -- \[runnerArgs\] -- \[appArgs\]`:' \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
'-o+[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'--output=[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'*-p+[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*--png=[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::input -- Path to the source icon (png, 1024x1024px with transparency):_files' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
'--interactive[Interactive mode to apply automatic fixes]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-A+[Name of your Tauri application]:APP_NAME: ' \
'--app-name=[Name of your Tauri application]:APP_NAME: ' \
'-W+[Window title of your Tauri application]:WINDOW_TITLE: ' \
'--window-title=[Window title of your Tauri application]:WINDOW_TITLE: ' \
'-D+[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'--dist-dir=[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'-P+[Url of your dev server]:DEV_PATH: ' \
'--dev-path=[Url of your dev server]:DEV_PATH: ' \
'--before-dev-command=[A shell command to run before \`tauri dev\` kicks in]:BEFORE_DEV_COMMAND: ' \
'--before-build-command=[A shell command to run before \`tauri build\` kicks in]:BEFORE_BUILD_COMMAND: ' \
'--ci[Skip prompting for values]' \
'-f[Force init to overwrite the src-tauri folder]' \
'--force[Force init to overwrite the src-tauri folder]' \
'-l[Enables logging]' \
'--log[Enables logging]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
'-n+[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'--name=[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-a+[Author name]:AUTHOR: ' \
'--author=[Author name]:AUTHOR: ' \
'--api[Initializes a Tauri plugin with TypeScript API]' \
'--tauri[Initializes a Tauri core plugin (internal usage)]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__plugin__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-help-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
'(-f --private-key-path)-k+[Load the private key from a string]:PRIVATE_KEY: ' \
'(-f --private-key-path)--private-key=[Load the private key from a string]:PRIVATE_KEY: ' \
'(-k --private-key)-f+[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'(-k --private-key)--private-key-path=[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':file -- Sign the specified file:_files' \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'-w+[Write private key to a file]:WRITE_KEYS:_files' \
'--write-keys=[Write private key to a file]:WRITE_KEYS:_files' \
'-f[Overwrite private key even if it exists on the specified path]' \
'--force[Overwrite private key even if it exists on the specified path]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__signer__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-help-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-s+[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'-o+[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'--output=[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_pnpm__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pnpm-help-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
":: :_pnpm__help__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pnpm-help-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_pnpm__help__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pnpm-help-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_pnpm__help__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pnpm-help-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_pnpm_commands] )) ||
_pnpm_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pnpm commands' commands "$@"
}
(( $+functions[_npm__run__tauri__build_commands] )) ||
_npm__run__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__build_commands] )) ||
_npm__run__tauri__help__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help build commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__build_commands] )) ||
_pnpm__help__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__completions_commands] )) ||
_npm__run__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__completions_commands] )) ||
_npm__run__tauri__help__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help completions commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__completions_commands] )) ||
_pnpm__help__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__dev_commands] )) ||
_npm__run__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__dev_commands] )) ||
_npm__run__tauri__help__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help dev commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__dev_commands] )) ||
_pnpm__help__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__generate_commands] )) ||
_npm__run__tauri__help__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__generate_commands] )) ||
_npm__run__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__generate_commands] )) ||
_npm__run__tauri__signer__help__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help generate commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__signer__generate_commands] )) ||
_pnpm__help__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help_commands] )) ||
_npm__run__tauri__help_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__help_commands] )) ||
_npm__run__tauri__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help_commands] )) ||
_npm__run__tauri__plugin__help_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__help_commands] )) ||
_npm__run__tauri__plugin__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help_commands] )) ||
_npm__run__tauri__signer__help_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__help_commands] )) ||
_npm__run__tauri__signer__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help help commands' commands "$@"
}
(( $+functions[_pnpm__help_commands] )) ||
_pnpm__help_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pnpm help commands' commands "$@"
}
(( $+functions[_pnpm__help__help_commands] )) ||
_pnpm__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__icon_commands] )) ||
_npm__run__tauri__help__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__icon_commands] )) ||
_npm__run__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri icon commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__icon_commands] )) ||
_pnpm__help__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__info_commands] )) ||
_npm__run__tauri__help__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__info_commands] )) ||
_npm__run__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri info commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__info_commands] )) ||
_pnpm__help__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__init_commands] )) ||
_npm__run__tauri__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin__init_commands] )) ||
_npm__run__tauri__help__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__init_commands] )) ||
_npm__run__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__init_commands] )) ||
_npm__run__tauri__plugin__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__init_commands] )) ||
_npm__run__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin init commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__init_commands] )) ||
_pnpm__help__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri init commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__plugin__init_commands] )) ||
_pnpm__help__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin_commands] )) ||
_npm__run__tauri__help__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'npm run tauri help plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin_commands] )) ||
_npm__run__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__plugin_commands] )) ||
_pnpm__help__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'pnpm help tauri plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__sign_commands] )) ||
_npm__run__tauri__help__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__sign_commands] )) ||
_npm__run__tauri__signer__help__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__sign_commands] )) ||
_npm__run__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer sign commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__signer__sign_commands] )) ||
_pnpm__help__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'pnpm help tauri signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer_commands] )) ||
_npm__run__tauri__help__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'npm run tauri help signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer_commands] )) ||
_npm__run__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri__signer_commands] )) ||
_pnpm__help__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'pnpm help tauri signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri_commands] )) ||
_npm__run__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri commands' commands "$@"
}
(( $+functions[_pnpm__help__tauri_commands] )) ||
_pnpm__help__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
    )
    _describe -t commands 'pnpm help tauri commands' commands "$@"
}

if [ "$funcstack[1]" = "_pnpm" ]; then
    _pnpm "$@"
else
    compdef _pnpm pnpm
fi

#compdef npm

autoload -U is-at-least

_npm() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_npm_commands" \
"*::: :->npm" \
&& ret=0
    case $state in
    (npm)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_npm__run_commands" \
"*::: :->run" \
&& ret=0

    case $state in
    (run)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'--runner=[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[Space or comma separated list of features to activate]' \
'*--features=[Space or comma separated list of features to activate]' \
'*-b+[Space or comma separated list of bundles to package]' \
'*--bundles=[Space or comma separated list of bundles to package]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'-d[Builds with the debug flag]' \
'--debug[Builds with the debug flag]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments:' \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to run the application]:RUNNER: ' \
'--runner=[Binary to use to run the application]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[List of cargo features to activate]' \
'*--features=[List of cargo features to activate]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--port=[Specify port for the dev server for static files. Defaults to 1430 Can also be set using \`TAURI_DEV_SERVER_PORT\` env var]:PORT: ' \
'-e[Exit on panic]' \
'--exit-on-panic[Exit on panic]' \
'--release[Run the code in release mode]' \
'--no-watch[Disable the file watcher]' \
'--no-dev-server[Disable the dev server for static files]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments. Arguments after a second `--` are passed to the application e.g. `tauri dev -- \[runnerArgs\] -- \[appArgs\]`:' \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
'-o+[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'--output=[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'*-p+[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*--png=[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::input -- Path to the source icon (png, 1024x1024px with transparency):_files' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
'--interactive[Interactive mode to apply automatic fixes]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-A+[Name of your Tauri application]:APP_NAME: ' \
'--app-name=[Name of your Tauri application]:APP_NAME: ' \
'-W+[Window title of your Tauri application]:WINDOW_TITLE: ' \
'--window-title=[Window title of your Tauri application]:WINDOW_TITLE: ' \
'-D+[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'--dist-dir=[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'-P+[Url of your dev server]:DEV_PATH: ' \
'--dev-path=[Url of your dev server]:DEV_PATH: ' \
'--before-dev-command=[A shell command to run before \`tauri dev\` kicks in]:BEFORE_DEV_COMMAND: ' \
'--before-build-command=[A shell command to run before \`tauri build\` kicks in]:BEFORE_BUILD_COMMAND: ' \
'--ci[Skip prompting for values]' \
'-f[Force init to overwrite the src-tauri folder]' \
'--force[Force init to overwrite the src-tauri folder]' \
'-l[Enables logging]' \
'--log[Enables logging]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
'-n+[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'--name=[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-a+[Author name]:AUTHOR: ' \
'--author=[Author name]:AUTHOR: ' \
'--api[Initializes a Tauri plugin with TypeScript API]' \
'--tauri[Initializes a Tauri core plugin (internal usage)]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__plugin__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-help-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
'(-f --private-key-path)-k+[Load the private key from a string]:PRIVATE_KEY: ' \
'(-f --private-key-path)--private-key=[Load the private key from a string]:PRIVATE_KEY: ' \
'(-k --private-key)-f+[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'(-k --private-key)--private-key-path=[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':file -- Sign the specified file:_files' \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'-w+[Write private key to a file]:WRITE_KEYS:_files' \
'--write-keys=[Write private key to a file]:WRITE_KEYS:_files' \
'-f[Overwrite private key even if it exists on the specified path]' \
'--force[Overwrite private key even if it exists on the specified path]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__signer__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-help-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-s+[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'-o+[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'--output=[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-help-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__help__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-help-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__help__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-help-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__help__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-help-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-help-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" \
":: :_npm__help__run_commands" \
"*::: :->run" \
&& ret=0

    case $state in
    (run)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-help-run-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
":: :_npm__help__run__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-help-run-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_npm__help__run__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-help-run-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_npm__help__run__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-help-run-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_npm_commands] )) ||
_npm_commands() {
    local commands; commands=(
'run:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__build_commands] )) ||
_npm__help__run__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri build commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__build_commands] )) ||
_npm__run__help__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__build_commands] )) ||
_npm__run__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__build_commands] )) ||
_npm__run__tauri__help__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help build commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__completions_commands] )) ||
_npm__help__run__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__completions_commands] )) ||
_npm__run__help__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__completions_commands] )) ||
_npm__run__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__completions_commands] )) ||
_npm__run__tauri__help__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help completions commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__dev_commands] )) ||
_npm__help__run__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__dev_commands] )) ||
_npm__run__help__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__dev_commands] )) ||
_npm__run__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__dev_commands] )) ||
_npm__run__tauri__help__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help dev commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__signer__generate_commands] )) ||
_npm__help__run__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__signer__generate_commands] )) ||
_npm__run__help__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__generate_commands] )) ||
_npm__run__tauri__help__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__generate_commands] )) ||
_npm__run__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__generate_commands] )) ||
_npm__run__tauri__signer__help__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help generate commands' commands "$@"
}
(( $+functions[_npm__help_commands] )) ||
_npm__help_commands() {
    local commands; commands=(
'run:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm help commands' commands "$@"
}
(( $+functions[_npm__help__help_commands] )) ||
_npm__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm help help commands' commands "$@"
}
(( $+functions[_npm__run__help_commands] )) ||
_npm__run__help_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run help commands' commands "$@"
}
(( $+functions[_npm__run__help__help_commands] )) ||
_npm__run__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help_commands] )) ||
_npm__run__tauri__help_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__help_commands] )) ||
_npm__run__tauri__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help_commands] )) ||
_npm__run__tauri__plugin__help_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__help_commands] )) ||
_npm__run__tauri__plugin__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help_commands] )) ||
_npm__run__tauri__signer__help_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__help_commands] )) ||
_npm__run__tauri__signer__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help help commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__icon_commands] )) ||
_npm__help__run__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri icon commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__icon_commands] )) ||
_npm__run__help__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__icon_commands] )) ||
_npm__run__tauri__help__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__icon_commands] )) ||
_npm__run__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri icon commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__info_commands] )) ||
_npm__help__run__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri info commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__info_commands] )) ||
_npm__run__help__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__info_commands] )) ||
_npm__run__tauri__help__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__info_commands] )) ||
_npm__run__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri info commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__init_commands] )) ||
_npm__help__run__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri init commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__plugin__init_commands] )) ||
_npm__help__run__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri plugin init commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__init_commands] )) ||
_npm__run__help__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri init commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__plugin__init_commands] )) ||
_npm__run__help__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__init_commands] )) ||
_npm__run__tauri__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin__init_commands] )) ||
_npm__run__tauri__help__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__init_commands] )) ||
_npm__run__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__init_commands] )) ||
_npm__run__tauri__plugin__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__init_commands] )) ||
_npm__run__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin init commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__plugin_commands] )) ||
_npm__help__run__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'npm help run tauri plugin commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__plugin_commands] )) ||
_npm__run__help__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'npm run help tauri plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin_commands] )) ||
_npm__run__tauri__help__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'npm run tauri help plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin_commands] )) ||
_npm__run__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin commands' commands "$@"
}
(( $+functions[_npm__help__run_commands] )) ||
_npm__help__run_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
    )
    _describe -t commands 'npm help run commands' commands "$@"
}
(( $+functions[_npm__run_commands] )) ||
_npm__run_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__signer__sign_commands] )) ||
_npm__help__run__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm help run tauri signer sign commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__signer__sign_commands] )) ||
_npm__run__help__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run help tauri signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__sign_commands] )) ||
_npm__run__tauri__help__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__sign_commands] )) ||
_npm__run__tauri__signer__help__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__sign_commands] )) ||
_npm__run__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer sign commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri__signer_commands] )) ||
_npm__help__run__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'npm help run tauri signer commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri__signer_commands] )) ||
_npm__run__help__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'npm run help tauri signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer_commands] )) ||
_npm__run__tauri__help__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'npm run tauri help signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer_commands] )) ||
_npm__run__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer commands' commands "$@"
}
(( $+functions[_npm__help__run__tauri_commands] )) ||
_npm__help__run__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
    )
    _describe -t commands 'npm help run tauri commands' commands "$@"
}
(( $+functions[_npm__run__help__tauri_commands] )) ||
_npm__run__help__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
    )
    _describe -t commands 'npm run help tauri commands' commands "$@"
}
(( $+functions[_npm__run__tauri_commands] )) ||
_npm__run__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri commands' commands "$@"
}

if [ "$funcstack[1]" = "_npm" ]; then
    _npm "$@"
else
    compdef _npm npm
fi

#compdef yarn

autoload -U is-at-least

_yarn() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_yarn_commands" \
"*::: :->yarn" \
&& ret=0
    case $state in
    (yarn)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:yarn-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'--runner=[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[Space or comma separated list of features to activate]' \
'*--features=[Space or comma separated list of features to activate]' \
'*-b+[Space or comma separated list of bundles to package]' \
'*--bundles=[Space or comma separated list of bundles to package]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'-d[Builds with the debug flag]' \
'--debug[Builds with the debug flag]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments:' \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to run the application]:RUNNER: ' \
'--runner=[Binary to use to run the application]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[List of cargo features to activate]' \
'*--features=[List of cargo features to activate]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--port=[Specify port for the dev server for static files. Defaults to 1430 Can also be set using \`TAURI_DEV_SERVER_PORT\` env var]:PORT: ' \
'-e[Exit on panic]' \
'--exit-on-panic[Exit on panic]' \
'--release[Run the code in release mode]' \
'--no-watch[Disable the file watcher]' \
'--no-dev-server[Disable the dev server for static files]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments. Arguments after a second `--` are passed to the application e.g. `tauri dev -- \[runnerArgs\] -- \[appArgs\]`:' \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
'-o+[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'--output=[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'*-p+[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*--png=[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::input -- Path to the source icon (png, 1024x1024px with transparency):_files' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
'--interactive[Interactive mode to apply automatic fixes]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-A+[Name of your Tauri application]:APP_NAME: ' \
'--app-name=[Name of your Tauri application]:APP_NAME: ' \
'-W+[Window title of your Tauri application]:WINDOW_TITLE: ' \
'--window-title=[Window title of your Tauri application]:WINDOW_TITLE: ' \
'-D+[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'--dist-dir=[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'-P+[Url of your dev server]:DEV_PATH: ' \
'--dev-path=[Url of your dev server]:DEV_PATH: ' \
'--before-dev-command=[A shell command to run before \`tauri dev\` kicks in]:BEFORE_DEV_COMMAND: ' \
'--before-build-command=[A shell command to run before \`tauri build\` kicks in]:BEFORE_BUILD_COMMAND: ' \
'--ci[Skip prompting for values]' \
'-f[Force init to overwrite the src-tauri folder]' \
'--force[Force init to overwrite the src-tauri folder]' \
'-l[Enables logging]' \
'--log[Enables logging]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
'-n+[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'--name=[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-a+[Author name]:AUTHOR: ' \
'--author=[Author name]:AUTHOR: ' \
'--api[Initializes a Tauri plugin with TypeScript API]' \
'--tauri[Initializes a Tauri core plugin (internal usage)]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__plugin__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-help-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
'(-f --private-key-path)-k+[Load the private key from a string]:PRIVATE_KEY: ' \
'(-f --private-key-path)--private-key=[Load the private key from a string]:PRIVATE_KEY: ' \
'(-k --private-key)-f+[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'(-k --private-key)--private-key-path=[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':file -- Sign the specified file:_files' \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'-w+[Write private key to a file]:WRITE_KEYS:_files' \
'--write-keys=[Write private key to a file]:WRITE_KEYS:_files' \
'-f[Overwrite private key even if it exists on the specified path]' \
'--force[Overwrite private key even if it exists on the specified path]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__signer__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-help-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-s+[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'-o+[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'--output=[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_yarn__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:yarn-help-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
":: :_yarn__help__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:yarn-help-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_yarn__help__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:yarn-help-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_yarn__help__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:yarn-help-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_yarn_commands] )) ||
_yarn_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'yarn commands' commands "$@"
}
(( $+functions[_npm__run__tauri__build_commands] )) ||
_npm__run__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__build_commands] )) ||
_npm__run__tauri__help__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help build commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__build_commands] )) ||
_yarn__help__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__completions_commands] )) ||
_npm__run__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__completions_commands] )) ||
_npm__run__tauri__help__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help completions commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__completions_commands] )) ||
_yarn__help__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__dev_commands] )) ||
_npm__run__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__dev_commands] )) ||
_npm__run__tauri__help__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help dev commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__dev_commands] )) ||
_yarn__help__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__generate_commands] )) ||
_npm__run__tauri__help__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__generate_commands] )) ||
_npm__run__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__generate_commands] )) ||
_npm__run__tauri__signer__help__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help generate commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__signer__generate_commands] )) ||
_yarn__help__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help_commands] )) ||
_npm__run__tauri__help_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__help_commands] )) ||
_npm__run__tauri__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help_commands] )) ||
_npm__run__tauri__plugin__help_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__help_commands] )) ||
_npm__run__tauri__plugin__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help_commands] )) ||
_npm__run__tauri__signer__help_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__help_commands] )) ||
_npm__run__tauri__signer__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help help commands' commands "$@"
}
(( $+functions[_yarn__help_commands] )) ||
_yarn__help_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'yarn help commands' commands "$@"
}
(( $+functions[_yarn__help__help_commands] )) ||
_yarn__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__icon_commands] )) ||
_npm__run__tauri__help__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__icon_commands] )) ||
_npm__run__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri icon commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__icon_commands] )) ||
_yarn__help__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__info_commands] )) ||
_npm__run__tauri__help__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__info_commands] )) ||
_npm__run__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri info commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__info_commands] )) ||
_yarn__help__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__init_commands] )) ||
_npm__run__tauri__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin__init_commands] )) ||
_npm__run__tauri__help__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__init_commands] )) ||
_npm__run__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__init_commands] )) ||
_npm__run__tauri__plugin__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__init_commands] )) ||
_npm__run__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin init commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__init_commands] )) ||
_yarn__help__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri init commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__plugin__init_commands] )) ||
_yarn__help__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin_commands] )) ||
_npm__run__tauri__help__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'npm run tauri help plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin_commands] )) ||
_npm__run__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__plugin_commands] )) ||
_yarn__help__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'yarn help tauri plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__sign_commands] )) ||
_npm__run__tauri__help__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__sign_commands] )) ||
_npm__run__tauri__signer__help__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__sign_commands] )) ||
_npm__run__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer sign commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__signer__sign_commands] )) ||
_yarn__help__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'yarn help tauri signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer_commands] )) ||
_npm__run__tauri__help__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'npm run tauri help signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer_commands] )) ||
_npm__run__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer commands' commands "$@"
}
(( $+functions[_yarn__help__tauri__signer_commands] )) ||
_yarn__help__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'yarn help tauri signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri_commands] )) ||
_npm__run__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri commands' commands "$@"
}
(( $+functions[_yarn__help__tauri_commands] )) ||
_yarn__help__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
    )
    _describe -t commands 'yarn help tauri commands' commands "$@"
}

if [ "$funcstack[1]" = "_yarn" ]; then
    _yarn "$@"
else
    compdef _yarn yarn
fi

#compdef bun

autoload -U is-at-least

_bun() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_bun_commands" \
"*::: :->bun" \
&& ret=0
    case $state in
    (bun)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_bun__run_commands" \
"*::: :->run" \
&& ret=0

    case $state in
    (run)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-run-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'--runner=[Binary to use to build the application, defaults to \`cargo\`]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[Space or comma separated list of features to activate]' \
'*--features=[Space or comma separated list of features to activate]' \
'*-b+[Space or comma separated list of bundles to package]' \
'*--bundles=[Space or comma separated list of bundles to package]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'-d[Builds with the debug flag]' \
'--debug[Builds with the debug flag]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments:' \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
'-r+[Binary to use to run the application]:RUNNER: ' \
'--runner=[Binary to use to run the application]:RUNNER: ' \
'-t+[Target triple to build against]:TARGET: ' \
'--target=[Target triple to build against]:TARGET: ' \
'*-f+[List of cargo features to activate]' \
'*--features=[List of cargo features to activate]' \
'-c+[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--config=[JSON string or path to JSON file to merge with tauri.conf.json]:CONFIG: ' \
'--port=[Specify port for the dev server for static files. Defaults to 1430 Can also be set using \`TAURI_DEV_SERVER_PORT\` env var]:PORT: ' \
'-e[Exit on panic]' \
'--exit-on-panic[Exit on panic]' \
'--release[Run the code in release mode]' \
'--no-watch[Disable the file watcher]' \
'--no-dev-server[Disable the dev server for static files]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::args -- Command line arguments passed to the runner. Use `--` to explicitly mark the start of the arguments. Arguments after a second `--` are passed to the application e.g. `tauri dev -- \[runnerArgs\] -- \[appArgs\]`:' \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
'-o+[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'--output=[Output directory. Default\: '\''icons'\'' directory next to the tauri.conf.json file]:OUTPUT:_files' \
'*-p+[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*--png=[Custom PNG icon sizes to generate. When set, the default icons are not generated]:PNG: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::input -- Path to the source icon (png, 1024x1024px with transparency):_files' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
'--interactive[Interactive mode to apply automatic fixes]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-A+[Name of your Tauri application]:APP_NAME: ' \
'--app-name=[Name of your Tauri application]:APP_NAME: ' \
'-W+[Window title of your Tauri application]:WINDOW_TITLE: ' \
'--window-title=[Window title of your Tauri application]:WINDOW_TITLE: ' \
'-D+[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'--dist-dir=[Web assets location, relative to <project-dir>/src-tauri]:DIST_DIR: ' \
'-P+[Url of your dev server]:DEV_PATH: ' \
'--dev-path=[Url of your dev server]:DEV_PATH: ' \
'--before-dev-command=[A shell command to run before \`tauri dev\` kicks in]:BEFORE_DEV_COMMAND: ' \
'--before-build-command=[A shell command to run before \`tauri build\` kicks in]:BEFORE_BUILD_COMMAND: ' \
'--ci[Skip prompting for values]' \
'-f[Force init to overwrite the src-tauri folder]' \
'--force[Force init to overwrite the src-tauri folder]' \
'-l[Enables logging]' \
'--log[Enables logging]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
'-n+[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'--name=[Name of your Tauri plugin]:PLUGIN_NAME: ' \
'-d+[Set target directory for init]:DIRECTORY: ' \
'--directory=[Set target directory for init]:DIRECTORY: ' \
'-t+[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'--tauri-path=[Path of the Tauri project to use (relative to the cwd)]:TAURI_PATH:_files' \
'-a+[Author name]:AUTHOR: ' \
'--author=[Author name]:AUTHOR: ' \
'--api[Initializes a Tauri plugin with TypeScript API]' \
'--tauri[Initializes a Tauri core plugin (internal usage)]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__plugin__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-plugin-help-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_npm__run__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
'(-f --private-key-path)-k+[Load the private key from a string]:PRIVATE_KEY: ' \
'(-f --private-key-path)--private-key=[Load the private key from a string]:PRIVATE_KEY: ' \
'(-k --private-key)-f+[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'(-k --private-key)--private-key-path=[Load the private key from a file]:PRIVATE_KEY_PATH:_files' \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
':file -- Sign the specified file:_files' \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
'-p+[Set private key password when signing]:PASSWORD: ' \
'--password=[Set private key password when signing]:PASSWORD: ' \
'-w+[Write private key to a file]:WRITE_KEYS:_files' \
'--write-keys=[Write private key to a file]:WRITE_KEYS:_files' \
'-f[Overwrite private key even if it exists on the specified path]' \
'--force[Overwrite private key even if it exists on the specified path]' \
'--ci[Skip prompting for values]' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__signer__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-signer-help-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-s+[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[Shell to generate a completion script for.]:SHELL:(bash elvish fish powershell zsh)' \
'-o+[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'--output=[Output file for the shell completions. By default the completions are printed to stdout]:OUTPUT:_files' \
'*-v[Enables verbose logging]' \
'*--verbose[Enables verbose logging]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_npm__run__tauri__help__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:npm-run-tauri-help-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_bun__run__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-run-help-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
":: :_bun__run__help__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-run-help-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_bun__run__help__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-run-help-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_bun__run__help__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-run-help-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_bun__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-help-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" \
":: :_bun__help__run_commands" \
"*::: :->run" \
&& ret=0

    case $state in
    (run)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-help-run-command-$line[1]:"
        case $line[1] in
            (tauri)
_arguments "${_arguments_options[@]}" \
":: :_bun__help__run__tauri_commands" \
"*::: :->tauri" \
&& ret=0

    case $state in
    (tauri)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-help-run-tauri-command-$line[1]:"
        case $line[1] in
            (build)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(dev)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(icon)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(plugin)
_arguments "${_arguments_options[@]}" \
":: :_bun__help__run__tauri__plugin_commands" \
"*::: :->plugin" \
&& ret=0

    case $state in
    (plugin)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-help-run-tauri-plugin-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(signer)
_arguments "${_arguments_options[@]}" \
":: :_bun__help__run__tauri__signer_commands" \
"*::: :->signer" \
&& ret=0

    case $state in
    (signer)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bun-help-run-tauri-signer-command-$line[1]:"
        case $line[1] in
            (sign)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_bun_commands] )) ||
_bun_commands() {
    local commands; commands=(
'run:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bun commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__build_commands] )) ||
_bun__help__run__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri build commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__build_commands] )) ||
_bun__run__help__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__build_commands] )) ||
_npm__run__tauri__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri build commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__build_commands] )) ||
_npm__run__tauri__help__build_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help build commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__completions_commands] )) ||
_bun__help__run__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri completions commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__completions_commands] )) ||
_bun__run__help__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__completions_commands] )) ||
_npm__run__tauri__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri completions commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__completions_commands] )) ||
_npm__run__tauri__help__completions_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help completions commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__dev_commands] )) ||
_bun__help__run__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri dev commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__dev_commands] )) ||
_bun__run__help__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__dev_commands] )) ||
_npm__run__tauri__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri dev commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__dev_commands] )) ||
_npm__run__tauri__help__dev_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help dev commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__signer__generate_commands] )) ||
_bun__help__run__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri signer generate commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__signer__generate_commands] )) ||
_bun__run__help__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__generate_commands] )) ||
_npm__run__tauri__help__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__generate_commands] )) ||
_npm__run__tauri__signer__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer generate commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__generate_commands] )) ||
_npm__run__tauri__signer__help__generate_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help generate commands' commands "$@"
}
(( $+functions[_bun__help_commands] )) ||
_bun__help_commands() {
    local commands; commands=(
'run:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bun help commands' commands "$@"
}
(( $+functions[_bun__help__help_commands] )) ||
_bun__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'bun help help commands' commands "$@"
}
(( $+functions[_bun__run__help_commands] )) ||
_bun__run__help_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bun run help commands' commands "$@"
}
(( $+functions[_bun__run__help__help_commands] )) ||
_bun__run__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help_commands] )) ||
_npm__run__tauri__help_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__help_commands] )) ||
_npm__run__tauri__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help_commands] )) ||
_npm__run__tauri__plugin__help_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__help_commands] )) ||
_npm__run__tauri__plugin__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help_commands] )) ||
_npm__run__tauri__signer__help_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer help commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__help_commands] )) ||
_npm__run__tauri__signer__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help help commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__icon_commands] )) ||
_bun__help__run__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri icon commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__icon_commands] )) ||
_bun__run__help__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__icon_commands] )) ||
_npm__run__tauri__help__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help icon commands' commands "$@"
}
(( $+functions[_npm__run__tauri__icon_commands] )) ||
_npm__run__tauri__icon_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri icon commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__info_commands] )) ||
_bun__help__run__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri info commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__info_commands] )) ||
_bun__run__help__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__info_commands] )) ||
_npm__run__tauri__help__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help info commands' commands "$@"
}
(( $+functions[_npm__run__tauri__info_commands] )) ||
_npm__run__tauri__info_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri info commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__init_commands] )) ||
_bun__help__run__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri init commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__plugin__init_commands] )) ||
_bun__help__run__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri plugin init commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__init_commands] )) ||
_bun__run__help__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri init commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__plugin__init_commands] )) ||
_bun__run__help__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__init_commands] )) ||
_npm__run__tauri__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin__init_commands] )) ||
_npm__run__tauri__help__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help plugin init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__init_commands] )) ||
_npm__run__tauri__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__help__init_commands] )) ||
_npm__run__tauri__plugin__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin help init commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin__init_commands] )) ||
_npm__run__tauri__plugin__init_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri plugin init commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__plugin_commands] )) ||
_bun__help__run__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'bun help run tauri plugin commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__plugin_commands] )) ||
_bun__run__help__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'bun run help tauri plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__plugin_commands] )) ||
_npm__run__tauri__help__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
    )
    _describe -t commands 'npm run tauri help plugin commands' commands "$@"
}
(( $+functions[_npm__run__tauri__plugin_commands] )) ||
_npm__run__tauri__plugin_commands() {
    local commands; commands=(
'init:Initializes a Tauri plugin project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri plugin commands' commands "$@"
}
(( $+functions[_bun__help__run_commands] )) ||
_bun__help__run_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
    )
    _describe -t commands 'bun help run commands' commands "$@"
}
(( $+functions[_bun__run_commands] )) ||
_bun__run_commands() {
    local commands; commands=(
'tauri:Command line interface for building Tauri apps' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bun run commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__signer__sign_commands] )) ||
_bun__help__run__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'bun help run tauri signer sign commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__signer__sign_commands] )) ||
_bun__run__help__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'bun run help tauri signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer__sign_commands] )) ||
_npm__run__tauri__help__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri help signer sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__help__sign_commands] )) ||
_npm__run__tauri__signer__help__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer help sign commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer__sign_commands] )) ||
_npm__run__tauri__signer__sign_commands() {
    local commands; commands=()
    _describe -t commands 'npm run tauri signer sign commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri__signer_commands] )) ||
_bun__help__run__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'bun help run tauri signer commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri__signer_commands] )) ||
_bun__run__help__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'bun run help tauri signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__help__signer_commands] )) ||
_npm__run__tauri__help__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
    )
    _describe -t commands 'npm run tauri help signer commands' commands "$@"
}
(( $+functions[_npm__run__tauri__signer_commands] )) ||
_npm__run__tauri__signer_commands() {
    local commands; commands=(
'sign:Sign a file' \
'generate:Generate keypair to sign files' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri signer commands' commands "$@"
}
(( $+functions[_bun__help__run__tauri_commands] )) ||
_bun__help__run__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
    )
    _describe -t commands 'bun help run tauri commands' commands "$@"
}
(( $+functions[_bun__run__help__tauri_commands] )) ||
_bun__run__help__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
    )
    _describe -t commands 'bun run help tauri commands' commands "$@"
}
(( $+functions[_npm__run__tauri_commands] )) ||
_npm__run__tauri_commands() {
    local commands; commands=(
'build:Tauri build' \
'dev:Tauri dev' \
'icon:Generates various icons for all major platforms' \
'info:Shows information about Tauri dependencies and project configuration' \
'init:Initializes a Tauri project' \
'plugin:Manage Tauri plugins' \
'signer:Tauri updater signer' \
'completions:Shell completions' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'npm run tauri commands' commands "$@"
}

if [ "$funcstack[1]" = "_bun" ]; then
    _bun "$@"
else
    compdef _bun bun
fi

