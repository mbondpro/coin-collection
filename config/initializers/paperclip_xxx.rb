require "paperclip"

if Rails.env == "development"
  Paperclip.options[:command_path] = "/usr/bin"
  Paperclip.options[:swallow_stderr] = false
end

