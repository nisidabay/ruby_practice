#!/usr/bin/env ruby
# frozen_string_literal: true

# app_launcher.rb — find and launch applications from .desktop entries via fzf

require 'open3'

INCLUDE_TERMINAL_APPS = true
FLATPAK_ICON = '󰏖 '
DIRS = ['/usr/share/applications', File.expand_path('~/.local/share/applications')]

app_list = []

def parse_desktop(filepath)
  data = { 'Name' => '', 'Exec' => '', 'Terminal' => 'false' }
  File.readlines(filepath).each do |line|
    if line.start_with?('Name=') && data['Name'].empty?
      data['Name'] = line.sub('Name=', '').strip
    elsif line.start_with?('Exec=') && data['Exec'].empty?
      data['Exec'] = line.sub('Exec=', '').gsub(/%[a-zA-Z]/, '').strip
    elsif line.start_with?('Terminal=')
      data['Terminal'] = line.sub('Terminal=', '').strip.downcase
    end
  end
  data
end

# Standard Apps
DIRS.each do |dir|
  next unless Dir.exist?(dir)
  Dir.glob(File.join(dir, '**/*.desktop')).each do |file|
    app = parse_desktop(file)
    next if app['Name'].empty? || app['Exec'].empty?

    is_term = app['Terminal'] == 'true'
    next if !INCLUDE_TERMINAL_APPS && is_term

    icon = is_term ? ' ' : '󰀻 '
    app_list << "#{icon} #{app['Name']} | #{app['Exec']} | #{file}"
  end
end

# Flatpaks
if system('command -v flatpak > /dev/null 2>&1')
  flatpak_out, = Open3.capture2('flatpak list --app --columns=application,name')
  flatpak_out.each_line do |line|
    id, name = line.strip.split("\t")
    next if id.nil? || id.empty?

    fp_dirs = [
      '/var/lib/flatpak/exports/share/applications',
      File.expand_path('~/.local/share/flatpak/exports/share/applications'),
    ]
    fp_dirs.each do |d|
      path = File.join(d, "#{id}.desktop")
      next unless File.exist?(path)

      app = parse_desktop(path)
      app_list << "#{FLATPAK_ICON}#{name} | #{app['Exec']} | #{path}" unless app['Exec'].empty?
      break
    end
  end
end

exit if app_list.empty?

# UI via fzf
fzf_cmd = [
  'fzf', '--style', 'full', '--delimiter', '|', '--with-nth', '1,2',
  '--height', '40%', '--layout', 'reverse', '--border',
  '--prompt', '🚀 Run: ', '--header', '󰀻 System | 󰏖 Flatpak |   Terminal'
]

selected = nil
Open3.popen2(*fzf_cmd) do |stdin, stdout, _wait_thr|
  stdin.puts(app_list.uniq.join("\n"))
  stdin.close
  selected = stdout.read.strip
end

unless selected.nil? || selected.empty?
  cmd = selected.split('|')[1].strip
  pid = Process.spawn(cmd, %i[out err] => '/dev/null')
  Process.detach(pid)
end

