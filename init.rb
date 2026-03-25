require 'redmine'

Rails.logger.info 'Starting Lift Attachments Limit plugin for Redmine'

Redmine::Plugin.register :redmine_lift_attachments_limit do
    name 'Lift Attachments Limit'
    author 'Leander Kretschmer'
    author_url 'https://github.com/leanderkretschmer'
    description 'Allows to configure how many attachments can be uploaded at once.'
    url 'https://github.com/leanderkretschmer/redmine_lift_attachments_limit'
    version '0.0.2'
    requires_redmine :version_or_higher => '6.0.0'

    settings :default => { 'attachments_limit' => 10 }, :partial => 'settings/attachments_limit'
end
