complete -c trash -n "__fish_use_subcommand" -s c -l color -d 'When to use colors' -r -f -a "{auto	,always	,never	}"
complete -c trash -n "__fish_use_subcommand" -s t -l table -d 'When to format as a table' -r -f -a "{auto	,always	,never	}"
complete -c trash -n "__fish_use_subcommand" -s h -l help -d 'Print help information (use `--help` for more detail)'
complete -c trash -n "__fish_use_subcommand" -s V -l version -d 'Print version information'
complete -c trash -n "__fish_use_subcommand" -f -a "list" -d 'List files'
complete -c trash -n "__fish_use_subcommand" -f -a "put" -d 'Put files'
complete -c trash -n "__fish_use_subcommand" -f -a "empty" -d 'PERMANANTLY removes files'
complete -c trash -n "__fish_use_subcommand" -f -a "restore" -d 'Restore files'
complete -c trash -n "__fish_use_subcommand" -f -a "completions" -d 'Generates completion for a shell'
complete -c trash -n "__fish_use_subcommand" -f -a "manpage" -d 'Generates manpages'
complete -c trash -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c trash -n "__fish_seen_subcommand_from list" -l before -l older-than -l older -d 'Filter by time (older than)' -r
complete -c trash -n "__fish_seen_subcommand_from list" -l within -l newer-than -l newer -d 'Filter by time' -r
complete -c trash -n "__fish_seen_subcommand_from list" -l regex -d 'Filter by regex' -r
complete -c trash -n "__fish_seen_subcommand_from list" -l glob -d 'Filter by glob' -r
complete -c trash -n "__fish_seen_subcommand_from list" -l substring -d 'Filter by substring' -r
complete -c trash -n "__fish_seen_subcommand_from list" -l exact -d 'Filter by exact match' -r
complete -c trash -n "__fish_seen_subcommand_from list" -s m -l match -d 'What type of pattern to use' -r -f -a "{regex	,substring	,glob	,exact	}"
complete -c trash -n "__fish_seen_subcommand_from list" -s d -l directory -l dir -d 'Filter by directory' -r -F
complete -c trash -n "__fish_seen_subcommand_from list" -s n -l max -d 'Show \'n\' maximum trash items' -r
complete -c trash -n "__fish_seen_subcommand_from list" -l rev -d 'Reverse the sorting of trash items'
complete -c trash -n "__fish_seen_subcommand_from list" -s h -l help -d 'Print help information (use `--help` for more detail)'
complete -c trash -n "__fish_seen_subcommand_from put" -s h -l help -d 'Print help information'
complete -c trash -n "__fish_seen_subcommand_from empty" -l before -l older-than -l older -d 'Filter by time (older than)' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -l within -l newer-than -l newer -d 'Filter by time' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -l regex -d 'Filter by regex' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -l glob -d 'Filter by glob' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -l substring -d 'Filter by substring' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -l exact -d 'Filter by exact match' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -s m -l match -d 'What type of pattern to use' -r -f -a "{regex	,substring	,glob	,exact	}"
complete -c trash -n "__fish_seen_subcommand_from empty" -s d -l directory -l dir -d 'Filter by directory' -r -F
complete -c trash -n "__fish_seen_subcommand_from empty" -s n -l max -d 'Show \'n\' maximum trash items' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -s r -l ranges -d 'Filter by ranges' -r
complete -c trash -n "__fish_seen_subcommand_from empty" -l rev -d 'Reverse the sorting of trash items'
complete -c trash -n "__fish_seen_subcommand_from empty" -l all -d 'Empty all files'
complete -c trash -n "__fish_seen_subcommand_from empty" -s f -l force -d 'Skip confirmation'
complete -c trash -n "__fish_seen_subcommand_from empty" -s h -l help -d 'Print help information (use `--help` for more detail)'
complete -c trash -n "__fish_seen_subcommand_from restore" -l before -l older-than -l older -d 'Filter by time (older than)' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -l within -l newer-than -l newer -d 'Filter by time' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -l regex -d 'Filter by regex' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -l glob -d 'Filter by glob' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -l substring -d 'Filter by substring' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -l exact -d 'Filter by exact match' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -s m -l match -d 'What type of pattern to use' -r -f -a "{regex	,substring	,glob	,exact	}"
complete -c trash -n "__fish_seen_subcommand_from restore" -s d -l directory -l dir -d 'Filter by directory' -r -F
complete -c trash -n "__fish_seen_subcommand_from restore" -s n -l max -d 'Show \'n\' maximum trash items' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -s r -l ranges -d 'Filter by ranges' -r
complete -c trash -n "__fish_seen_subcommand_from restore" -l rev -d 'Reverse the sorting of trash items'
complete -c trash -n "__fish_seen_subcommand_from restore" -s f -l force -d 'Skip confirmation'
complete -c trash -n "__fish_seen_subcommand_from restore" -s h -l help -d 'Print help information (use `--help` for more detail)'
complete -c trash -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help information'
complete -c trash -n "__fish_seen_subcommand_from manpage" -s h -l help -d 'Print help information'
complete -c trash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from put; and not __fish_seen_subcommand_from empty; and not __fish_seen_subcommand_from restore; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from manpage; and not __fish_seen_subcommand_from help" -f -a "list" -d 'List files'
complete -c trash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from put; and not __fish_seen_subcommand_from empty; and not __fish_seen_subcommand_from restore; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from manpage; and not __fish_seen_subcommand_from help" -f -a "put" -d 'Put files'
complete -c trash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from put; and not __fish_seen_subcommand_from empty; and not __fish_seen_subcommand_from restore; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from manpage; and not __fish_seen_subcommand_from help" -f -a "empty" -d 'PERMANANTLY removes files'
complete -c trash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from put; and not __fish_seen_subcommand_from empty; and not __fish_seen_subcommand_from restore; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from manpage; and not __fish_seen_subcommand_from help" -f -a "restore" -d 'Restore files'
complete -c trash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from put; and not __fish_seen_subcommand_from empty; and not __fish_seen_subcommand_from restore; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from manpage; and not __fish_seen_subcommand_from help" -f -a "completions" -d 'Generates completion for a shell'
complete -c trash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from put; and not __fish_seen_subcommand_from empty; and not __fish_seen_subcommand_from restore; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from manpage; and not __fish_seen_subcommand_from help" -f -a "manpage" -d 'Generates manpages'
complete -c trash -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from put; and not __fish_seen_subcommand_from empty; and not __fish_seen_subcommand_from restore; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from manpage; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
