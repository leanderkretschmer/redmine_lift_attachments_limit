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

# Add JavaScript to the page header for attachment forms
class LiftAttachmentsLimitHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context)
    max_uploads = Setting.plugin_redmine_lift_attachments_limit['attachments_limit'].to_i
    max_uploads = 10 if max_uploads <= 0
    
    javascript_tag("window.maxFileUploads = #{max_uploads};") +
    javascript_include_tag('attachments', :plugin => 'redmine_lift_attachments_limit')
  end
end