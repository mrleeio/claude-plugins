# mrleeio-claude-plugins

Personal Claude Code plugins marketplace.

## Installation

Install any plugin from this marketplace:

```bash
/plugin install {plugin-name}@mrleeio/claude-plugins
```

Or browse available plugins:

```bash
/plugin
```

Then select "Discover" and enter `mrleeio/claude-plugins`.

## Available Plugins

| Plugin | Description |
|--------|-------------|
| [conventional-commits](plugins/conventional-commits) | Create git commits following Conventional Commits v1.0.0 without AI attribution |

## Adding a Plugin

Each plugin follows this structure:

```
plugins/
└── your-plugin-name/
    ├── .claude-plugin/
    │   └── plugin.json    # Required: plugin metadata
    ├── commands/          # Optional: slash commands
    ├── agents/            # Optional: agent definitions
    ├── skills/            # Optional: skill definitions
    └── README.md          # Recommended: documentation
```

### Minimal plugin.json

```json
{
  "name": "your-plugin-name",
  "description": "What your plugin does",
  "version": "1.0.0"
}
```

## License

MIT
