# python-project-template

## About this template

(This section is the only one you'd want to delete after cloning this template)

By cloning this template you get a mindfully configured dev container for python development with:

- Pipenv
- Basic test infrastructure (using pytest) integrated with VSCode
- Basic logging config
- Basic environment variables settings setup
- Basic debugging setup in VSCode
- A good dockerfile & docker-compose config
- A GitHub Action that runs the tests on push to master
- VSCode extensions:
- Python
- Sourcery (not working for amd64/Apple Silicon)

And all this works straight out of the box.

Just replace all the occurrences of "python-project-template" with your project's name.

(End of template section)

## Development stuff

### Prerequisites

1. Docker
2. VSCode
3. the VSCode `Dev Containers` extension (`ms-vscode-remote.remote-containers`)

### Setting up the development environment

1. Make sure docker is running
2. Open this repo in VSCode
3. You might get a warning saying that an invalid python interpreter is selected. Ignore it, the python interpreter will be created inside the dev container we're going to use.
4. The VSCode Dev Containers extension will suggest you to "Reopen in Container", do it:
   ![vscode-devcontainers-popup.png](/docs/images/vscode-devcontainers-popup.png)

   Otherwise, you can just search "Reopen in Container" in the command palette.

5. You should now be able to run and debug `src/main.py`.

### Running locally (inside the container)

```bash
# Should be run inside the venv:
python src/main.py
```

### Debugging

You can use the "Python: src/main.py" debug config that is defined in `.vscode/launch.json`.

### Adding new dependencies

Dev dependencies:

```bash
pipenv install --dev <dependency-name>
```

Production dependencies:

```bash
pipenv install <dependency-name>
```

### Build for production

First, make sure your terminal is running on your host (outside the dev container).  
Then, run:

```bash
docker-compose build
```

And you will end up with a docker image of your code.

If you want to use settings from a `.env` file, uncomment the relevant line in `docker-compose.yml`.

### How to run a production version of the code

First, make sure your terminal is running on your host (outside the dev container).  
Then, run:

```bash
docker-compose up

# Or, if you want to run it in the background:
docker-compose up -d
```

<details>
   <summary>Troubleshooting</summary>
   
   1. It looks like VSCode doesn't detect any of the python dependencies / The Testing tab says "Pytest Discovery Error":
   
      1. This might happen because VSCode failed to use the right python interpreter. Here's how to fix this:
         1. Open any python file (`.py`)
         2. In the bottom right corner, change the python interpreter to the one inside our project's venv:
            ![vscode-python-interpreter](/docs/images/vscode-python-interpreter.png)
            ![vscode-python-select-venv-interpreter](/docs/images/vscode-python-select-venv-interpreter.png)
         3. Kill the terminal (`Ctrl+D`) and start a new one (`` Ctrl+` ``).
         4. The new terminal should look like this:
            ![vscode-terminal-init-inside-venv](/docs/images/vscode-terminal-init-inside-venv.png)
   
   1. Can't push/pull inside the dev container, it says something about missing credentials
      1. If you are accessing Github with an SSH key, it might not be passed into the container properly. (should happen automatically)
         To check if it's available inside the container, run `ssh-add -l`. If it says "The agent has no identities.", you need to add it on your host machine (outside of the dev container). You can do it by running `ssh-add <path-to-private-key>` and restart your dev container (which you can do by closing and re-opening the VSCode window)
</details>

<details>
   <summary>Q&A</summary>
   
   - Q: Why is the venv inside the project folder?
     - A: This is done in order to make the python interpreter have a constant path so VSCode will always know where to find it without the developer having to manually configure it.
</details>
