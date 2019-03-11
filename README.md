# dotfiles

## How to restore

- Add this alias in your shell
`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

- Ignore .cfg directory
`echo ".cfg" >> .gitignore`

- Clone github repository
`git clone --bare https://github.com/chocobn69/dotfiles.git $HOME/.cfg`

- Backup previously added config files
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

- Get remote files
`config checkout`

- Ignore untracked files
`config config --local status.showUntrackedFiles no`
