# Enable live editing for a config in chezmoi
watch config_dir path=("/home/austin/.local/share/chezmoi/dot_config/" + config_dir):
    #!/usr/bin/env zsh
    @echo "Watching {{ path }}..."
    watchman watch {{ path }}
    watchman -j <<EOT
    ["trigger", "{{ path }}", {
    "name": "chezmoi-apply",
    "command": ["chezmoi", "apply", "--force"]
    }]
    EOT
