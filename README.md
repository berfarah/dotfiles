# Bernardo's Dotfiles

Get going quickly by copy-pasting the below into your terminal:

```sh
bash -c "$(curl -L https://raw.githubusercontent.com/berfarah/dotfiles/master/bin/setup.sh)"
```

### Caveats

- For parts of this script to work, you need to be logged into the app
store.
- The cask install for `docker-machine` fails because you need to allow the
virtualbox app through a panel in `System Preferences > Security`.
- There are some password prompts during the installation process. These are for
  `java8` and `docker-machine`. Unfortunately, short of not installing some of
  this software on initial install, there is no way around this.

### [Software used](./Brewfile)
