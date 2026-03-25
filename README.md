# Lift Attachments Limit Plugin for Redmine

This plugin allows you to configure the maximum number of attachments that can be uploaded simultaneously in Redmine.

## Features

- Configure the maximum number of simultaneous file uploads
- Easy-to-use settings interface
- Compatible with Redmine 6.0+

## Installation

1. Download the plugin and extract it to your Redmine plugins directory:
   ```bash
   cd /path/to/redmine/plugins
   git clone https://github.com/leanderkretschmer/redmine_lift_attachments_limit.git lift_attachments_limit
   ```

2. Install the plugin:
   ```bash
   cd /path/to/redmine
   bundle install
   rake redmine:plugins:migrate RAILS_ENV=production
   ```

3. Restart your Redmine server

4. Configure the plugin in Administration → Plugins → Lift Attachments Limit → Configure

## Configuration

After installation, you can configure the plugin by:

1. Going to Administration → Plugins
2. Clicking on "Configure" next to "Lift Attachments Limit"
3. Setting the "Maximum number of simultaneous file uploads" to your desired value
4. Clicking "Apply"

## Compatibility

- **Redmine 6.0+** (Plugin version 0.0.2+)
- Ruby 3.0+
- Rails 7.0+

## Upgrade from Previous Versions

### Upgrading to 0.0.2 (Redmine 6 compatible)

1. Backup your current plugin settings
2. Update the plugin files
3. Run the migration:
   ```bash
   cd /path/to/redmine
   rake redmine:plugins:migrate RAILS_ENV=production
   ```
4. Restart your Redmine server

## Development

### Plugin Structure

```
lift_attachments_limit/
├── app/
│   └── views/
│       ├── attachments/
│       │   └── _form.html.erb          # Modified attachments form
│       └── settings/
│           └── _attachments_limit.html.erb  # Settings UI
├── assets/
│   └── javascripts/
│       └── attachments.js              # JavaScript functionality
├── config/
│   └── locales/
│       └── en.yml                      # English translations
└── init.rb                             # Plugin registration
```

### Key Changes in 0.0.2

- Updated for Redmine 6 compatibility
- Modern JavaScript (ES6+) replacing jQuery dependency
- Updated Rails rendering syntax
- Added Redmine version requirement

## Support

For issues and feature requests, please use the GitHub issue tracker.

## License

This plugin is released under the MIT License.