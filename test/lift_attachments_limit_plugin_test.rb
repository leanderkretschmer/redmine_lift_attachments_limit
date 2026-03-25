# Test validation for Redmine 6 compatibility - Hook-based approach

require 'test_helper'

class LiftAttachmentsLimitPluginTest < ActiveSupport::TestCase
  
  def setup
    @plugin = Redmine::Plugin.find(:redmine_lift_attachments_limit)
  end
  
  test "plugin should be registered with correct ID" do
    assert_not_nil @plugin
    assert_equal 'Lift Attachments Limit', @plugin.name
    assert_equal '0.0.2', @plugin.version
  end
  
  test "plugin should require Redmine 6.0 or higher" do
    # This will be validated by Redmine during plugin loading
    assert @plugin.requires_redmine[:version_or_higher] >= '6.0.0'
  end
  
  test "plugin should have default settings" do
    assert_equal 10, Setting.plugin_redmine_lift_attachments_limit['attachments_limit'].to_i
  end
  
  test "plugin should load JavaScript correctly" do
    # Test that the JavaScript file exists and is accessible
    plugin_dir = Redmine::Plugin.find(:redmine_lift_attachments_limit).directory
    assert File.exist?(File.join(plugin_dir, 'assets', 'javascripts', 'attachments.js'))
  end
  
  test "hook class should be defined" do
    assert defined?(LiftAttachmentsLimitHooks)
    assert_equal Redmine::Hook::ViewListener, LiftAttachmentsLimitHooks.superclass
  end
  
  test "hook should add JavaScript to header" do
    hook = LiftAttachmentsLimitHooks.new
    result = hook.view_layouts_base_html_head({})
    
    assert result.include?('window.maxFileUploads')
    assert result.include?('attachments.js')
  end
  
end