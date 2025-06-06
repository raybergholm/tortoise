# Tortoise - make your shell cooler

🐢🐢🐢

Shell configs have a habit of sprawling out of control. As we add bits and pieces from different development environments, your shell setup may turn into a convoluted mess that's hard to navagate.

Use tortoise to help you deal with that! It offers suggestions for organising your shell configs, and comes bundled with some handy functions for common actions during development.

Developed for Mac running a zsh shell.

## Setup

Clone this repository:

```bash
git clone git@github.com:raybergholm/tortoise.git
```

Add the following snippet to your `.zshrc` file (default location: `$HOME/.zshrc`):

```bash
export TORTOISE_ROOT="path/to/your/cloned/repository"
source "$TORTOISE_ROOT/zsh_root.sh"
```

In the src folder, copy the secrets sample folder:

```bash
cp ./secrets.sample.sh ./secrets.sh
```

Reload your shell to apply your changes:

```bash
source "$HOME/.zshrc"
```

## Docs

[Built-in functions for your convenience](./docs/docs.md#Built-in functions)
