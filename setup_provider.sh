if [ -d "$HOME/.virtualenvs" ]; then
  echo "$HOME/.virtualenvs exists."
else
  mkdir "$HOME/.virtualenvs"
fi

if [ -x "$HOME/.virtualenvs/neovim/bin/python" ]; then
  echo "$HOME/.virtualenvs/neovim/bin/python exists."
else
  python -m venv "$HOME/.virtualenvs/neovim"
fi

"$HOME/.virtualenvs/neovim/bin/python" -m pip install --upgrade pip
"$HOME/.virtualenvs/neovim/bin/python" -m pip install pynvim debugpy
