# Test validation for Redmine 6 compatibility

require 'test_helper'

class LiftAttachmentsLimitPluginTest < ActiveSupport::TestCase
  
  def setup
    @plugin = Redmine::Plugin.find(:lift_attachments_limit)
  end
  
  test "plugin should be registered" do
    assert_not_nil @plugin
    assert_equal 'Lift Attachments Limit', @plugin.name
    assert_equal '0.0.2', @plugin.version
  end
  
  test "plugin should require Redmine 6.0 or higher" do
    # This will be validated by Redmine during plugin loading
    assert @plugin.requires_redmine[:version_or_higher] >= '6.0.0'
  end
  
  test "plugin should have default settings" do
    assert_equal 10, Setting.plugin_lift_attachments_limit['attachments_limit'].to_i
  end
  
  test "plugin should load JavaScript correctly" do
    # Test that the JavaScript file exists and is accessible
    assert File.exist?(File.join(Redmine::Plugin.find(:lift_attachments_limit).directory, 'assets', 'javascripts', 'attachments.js'))
  end
  
  test "plugin views should be accessible" do
    # Test that view files exist
    plugin_dir = Redmine::Plugin.find(:lift_attachments_limit).directory
    assert File.exist?(File.join(plugin_dir, 'app', 'views', 'attachments', '_form.html.erb'))
    assert File.exist?(File.join(plugin_dir, 'app', 'views', 'settings', '_attachments_limit.html.erb'))
  end
  
end