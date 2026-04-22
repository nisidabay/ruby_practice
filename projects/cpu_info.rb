#!/usr/bin/env ruby
require 'fileutils'

def get_system_info
  puts "=" * 50
  puts "INFORMACIÓN DEL SISTEMA"
  puts "=" * 50
  puts "\n"

  # --- Información de la plataforma ---
  require 'rubygems'
  begin
    require 'ruby-platform'
  rescue LoadError
    # Plataforma no especificada o no disponible
  end

  puts "Plataforma: #{RUBY_PLATFORM}"
  puts "Ruby Version: #{RUBY_VERSION}"
  puts "\n"

  # --- CPU ---
  begin
    # Leer archivo /proc/cpuinfo (solo Linux)
    if File.exist?('/proc/cpuinfo')
      cpu_info = File.readlines('/proc/cpuinfo').select { |line| line.include?('model name') }
      model_name = cpu_info.map { |line| line.split(':').last.strip }.first
      cores = File.readlines('/proc/cpuinfo').grep(/processor/).size
      cache_line = File.readlines('/proc/cpuinfo').grep(/cache_size/).map { |line| line.split(':').last.strip }.first

      puts "CPU Model: #{model_name || 'No disponible'}"
      puts "Núcleos Físicos: #{cores}"
      puts "CPU Cache: #{cache_line || 'No disponible'}"
    else
      puts "CPU: No disponible (solo compatible con Linux)"
    end
  rescue => e
    puts "Error al obtener información de CPU: #{e.message}"
  end
  puts "\n"

  # --- Memoria ---
  begin
    # Leer archivo /proc/meminfo
    meminfo = File.readlines('/proc/meminfo')
    total_mem = meminfo.select { |line| line.include?('MemTotal') }.map { |line| line.split(':').last.strip.split('=')[0] }.first
    free_mem = meminfo.select { |line| line.include?('MemFree') }.map { |line| line.split(':').last.strip.split('=')[0] }.first
    available_mem = meminfo.select { |line| line.include?('MemAvailable') }.map { |line| line.split(':').last.strip.split('=')[0] }.first

    puts "Memoria Total: #{total_mem || 'N/A'} KB"
    puts "Memoria Libre: #{free_mem || 'N/A'} KB"
    puts "Memoria Disponible: #{available_mem || 'N/A'} KB"
  rescue => e
    puts "Error al obtener información de memoria: #{e.message}"
  end
  puts "\n"

  # --- Discos ---
  begin
    if File.exist?('/proc/partitions')
      disk_info = File.readlines('/proc/partitions')
      disk_list = disk_info.map { |line| line.split[2].strip }.reject { |name| name == 'device' }.uniq
      disk_list.each do |device|
        begin
          begin
            total = `sudo cat /sys/block/#{device}/size`.chomp.to_i * 2 ** 20
            free = `sudo cat /sys/block/#{device}/bdi/readahead`.chomp.to_i.to_i.to_f
          rescue
            total = File.read("/sys/block/#{device}/size").chomp.to_i * 2 ** 20
            free = 0
          end
          puts "Disco: #{device} (Total: #{total.to_i} MB, Libre: #{free} MB)"
        rescue => e
          puts "Error leyendo disco #{device}: #{e.message}"
        end
      end
    else
      puts "Información de disco no disponible."
    end
  rescue => e
    puts "Error al obtener información de disco: #{e.message}"
  end
  puts "\n"

  # --- Procesadores en ejecución ---
  begin
    load_procs = `ps -p 1 -o stat=`.chomp rescue nil
    puts "Proceso principal (PID 1): #{load_procs || 'No disponible'}"
  rescue => e
    puts "Error obteniendo info de procesos: #{e.message}"
  end
  puts "\n"

  # --- Uso de memoria actual ---
  begin
    load_mem = `free -m`.strip
    puts "Uso de memoria:"
    puts load_mem.lines[1].sub(/\s*$/, "")
  rescue => e
    puts "Error obteniendo uso de memoria: #{e.message}"
  end
  puts "\n"

  puts "=" * 50
  puts "Información completada."
  puts "=" * 50
end

get_system_info
