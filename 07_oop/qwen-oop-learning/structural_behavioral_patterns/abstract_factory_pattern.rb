#!/usr/bin/env ruby

# Abstract Factory Pattern — Create Families of Related Objects
# Core Idea: Provide an interface for creating families of related or dependent
# objects without specifying their concrete classes.


# =============================================================================
# 1. THE ABSTRACT FACTORY INTERFACE
# =============================================================================

class GUIFactory
  def create_button; end
  def create_checkbox; end
  def create_menu; end
end


# =============================================================================
# 2. CONCRETE PRODUCTS - WINDOWS FAMILY
# =============================================================================

class WindowsButton
  def render
    puts "  [WindowsButton] Rendering Windows-style button"
  end

  def click
    puts "  [WindowsButton] Clicked with Windows animation"
  end
end

class WindowsCheckbox
  def render
    puts "  [WindowsCheckbox] Rendering Windows-style checkbox"
  end

  def toggle
    puts "  [WindowsCheckbox] Toggled with Windows style"
  end
end

class WindowsMenu
  def render
    puts "  [WindowsMenu] Rendering Windows menu bar"
  end

  def select(item)
    puts "  [WindowsMenu] Selected: #{item}"
  end
end


# =============================================================================
# 3. CONCRETE PRODUCTS - MAC FAMILY
# =============================================================================

class MacButton
  def render
    puts "  [MacButton] Rendering Mac-style button"
  end

  def click
    puts "  [MacButton] Clicked with Mac animation"
  end
end

class MacCheckbox
  def render
    puts "  [MacCheckbox] Rendering Mac-style checkbox"
  end

  def toggle
    puts "  [MacCheckbox] Toggled with Mac style"
  end
end

class MacMenu
  def render
    puts "  [MacMenu] Rendering Mac menu bar"
  end

  def select(item)
    puts "  [MacMenu] Selected: #{item}"
  end
end


# =============================================================================
# 4. CONCRETE PRODUCTS - LINUX FAMILY
# =============================================================================

class LinuxButton
  def render
    puts "  [LinuxButton] Rendering GTK button"
  end

  def click
    puts "  [LinuxButton] Clicked with GTK feedback"
  end
end

class LinuxCheckbox
  def render
    puts "  [LinuxCheckbox] Rendering GTK checkbox"
  end

  def toggle
    puts "  [LinuxCheckbox] Toggled with GTK style"
  end
end

class LinuxMenu
  def render
    puts "  [LinuxMenu] Rendering GTK menu"
  end

  def select(item)
    puts "  [LinuxMenu] Selected: #{item}"
  end
end


# =============================================================================
# 5. CONCRETE FACTORIES
# =============================================================================

class WindowsFactory < GUIFactory
  def create_button
    WindowsButton.new
  end

  def create_checkbox
    WindowsCheckbox.new
  end

  def create_menu
    WindowsMenu.new
  end
end

class MacFactory < GUIFactory
  def create_button
    MacButton.new
  end

  def create_checkbox
    MacCheckbox.new
  end

  def create_menu
    MacMenu.new
  end
end

class LinuxFactory < GUIFactory
  def create_button
    LinuxButton.new
  end

  def create_checkbox
    LinuxCheckbox.new
  end

  def create_menu
    LinuxMenu.new
  end
end


# =============================================================================
# 6. THE CLIENT (Application)
# =============================================================================

class Application
  def initialize(factory)
    @factory = factory
    @button = nil
    @checkbox = nil
    @menu = nil
  end

  def render
    puts "\n[Application] Rendering UI components:"
    
    @button = @factory.create_button
    @button.render
    
    @checkbox = @factory.create_checkbox
    @checkbox.render
    
    @menu = @factory.create_menu
    @menu.render
  end

  def interact
    puts "\n[Application] User interactions:"
    @button.click
    @checkbox.toggle
    @menu.select("File > Open")
  end
end


# =============================================================================
# 7. REAL-WORLD EXAMPLE: Database Abstract Factory
# =============================================================================

class DatabaseFactory
  def create_connection; end
  def create_query_builder; end
  def create_transaction; end
end

class MySQLFactory < DatabaseFactory
  def create_connection
    puts "  [Factory] Creating MySQLConnection"
    MySQLConnection.new
  end

  def create_query_builder
    puts "  [Factory] Creating MySQLQueryBuilder"
    MySQLQueryBuilder.new
  end

  def create_transaction
    puts "  [Factory] Creating MySQLTransaction"
    MySQLTransaction.new
  end
end

class PostgreSQLFactory < DatabaseFactory
  def create_connection
    puts "  [Factory] Creating PostgreSQLConnection"
    PostgreSQLConnection.new
  end

  def create_query_builder
    puts "  [Factory] Creating PostgreSQLQueryBuilder"
    PostgreSQLQueryBuilder.new
  end

  def create_transaction
    puts "  [Factory] Creating PostgreSQLTransaction"
    PostgreSQLTransaction.new
  end
end

class MongoDBFactory < DatabaseFactory
  def create_connection
    puts "  [Factory] Creating MongoDBConnection"
    MongoDBConnection.new
  end

  def create_query_builder
    puts "  [Factory] Creating MongoDBQueryBuilder"
    MongoDBQueryBuilder.new
  end

  def create_transaction
    puts "  [Factory] Creating MongoDBTransaction"
    MongoDBTransaction.new
  end
end

# MySQL Products
class MySQLConnection
  def connect
    puts "  [MySQLConnection] Connecting to MySQL server"
  end
end

class MySQLQueryBuilder
  def build_select(table)
    puts "  [MySQLQueryBuilder] Building SELECT * FROM #{table}"
  end
end

class MySQLTransaction
  def begin
    puts "  [MySQLTransaction] BEGIN TRANSACTION"
  end
end

# PostgreSQL Products
class PostgreSQLConnection
  def connect
    puts "  [PostgreSQLConnection] Connecting to PostgreSQL server"
  end
end

class PostgreSQLQueryBuilder
  def build_select(table)
    puts "  [PostgreSQLQueryBuilder] Building SELECT * FROM #{table}"
  end
end

class PostgreSQLTransaction
  def begin
    puts "  [PostgreSQLTransaction] BEGIN TRANSACTION"
  end
end

# MongoDB Products
class MongoDBConnection
  def connect
    puts "  [MongoDBConnection] Connecting to MongoDB cluster"
  end
end

class MongoDBQueryBuilder
  def build_select(collection)
    puts "  [MongoDBQueryBuilder] Building db.#{collection}.find({})"
  end
end

class MongoDBTransaction
  def begin
    puts "  [MongoDBTransaction] Starting session"
  end
end


# =============================================================================
# 8. REAL-WORLD EXAMPLE: Cloud Providers
# =============================================================================

class CloudFactory
  def create_compute; end
  def create_storage; end
  def create_networking; end
end

class AWSFactory < CloudFactory
  def create_compute
    puts "  [Factory] Creating AWS EC2 instance"
    EC2Instance.new
  end

  def create_storage
    puts "  [Factory] Creating AWS S3 bucket"
    S3Bucket.new
  end

  def create_networking
    puts "  [Factory] Creating AWS VPC"
    AWSVPC.new
  end
end

class GCPFactory < CloudFactory
  def create_compute
    puts "  [Factory] Creating GCP Compute Engine"
    GCPCompute.new
  end

  def create_storage
    puts "  [Factory] Creating GCP Cloud Storage"
    GCPCloudStorage.new
  end

  def create_networking
    puts "  [Factory] Creating GCP VPC"
    GCPVPC.new
  end
end

class AzureFactory < CloudFactory
  def create_compute
    puts "  [Factory] Creating Azure VM"
    AzureVM.new
  end

  def create_storage
    puts "  [Factory] Creating Azure Blob Storage"
    AzureBlob.new
  end

  def create_networking
    puts "  [Factory] Creating Azure VNet"
    AzureVNet.new
  end
end

# AWS Products
class EC2Instance
  def start
    puts "  [EC2] Starting instance"
  end
end

class S3Bucket
  def upload(file)
    puts "  [S3] Uploading #{file}"
  end
end

class AWSVPC
  def create_subnet
    puts "  [AWS VPC] Creating subnet"
  end
end

# GCP Products
class GCPCompute
  def start
    puts "  [GCP Compute] Starting instance"
  end
end

class GCPCloudStorage
  def upload(file)
    puts "  [GCS] Uploading #{file}"
  end
end

class GCPVPC
  def create_subnet
    puts "  [GCP VPC] Creating subnet"
  end
end

# Azure Products
class AzureVM
  def start
    puts "  [Azure VM] Starting virtual machine"
  end
end

class AzureBlob
  def upload(file)
    puts "  [Azure Blob] Uploading #{file}"
  end
end

class AzureVNet
  def create_subnet
    puts "  [Azure VNet] Creating subnet"
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Abstract Factory Pattern Demo ===\n\n"

# GUI Factory example
puts "--- Cross-Platform GUI ---"

# Detect or configure the OS
os = "mac"  # Could be: "windows", "mac", "linux"

factory = case os
          when "windows" then WindowsFactory.new
          when "mac" then MacFactory.new
          else LinuxFactory.new
          end

app = Application.new(factory)
app.render
app.interact

# Try different factory
puts "\n--- Switching to Windows Theme ---"
windows_factory = WindowsFactory.new
windows_app = Application.new(windows_factory)
windows_app.render

# Database example
puts "\n--- Database Abstract Factory ---"

db_type = "mysql"  # Configurable

db_factory = case db_type
             when "mysql" then MySQLFactory.new
             when "postgresql" then PostgreSQLFactory.new
             when "mongodb" then MongoDBFactory.new
             else raise "Unknown database type"
             end

conn = db_factory.create_connection
conn.connect

qb = db_factory.create_query_builder
qb.build_select("users")

tx = db_factory.create_transaction
tx.begin

# Cloud provider example
puts "\n--- Cloud Provider Abstract Factory ---"

cloud = "aws"  # Configurable: "aws", "gcp", "azure"

cloud_factory = case cloud
                when "aws" then AWSFactory.new
                when "gcp" then GCPFactory.new
                when "azure" then AzureFactory.new
                else raise "Unknown cloud provider"
                end

compute = cloud_factory.create_compute
compute.start

storage = cloud_factory.create_storage
storage.upload("data.csv")

network = cloud_factory.create_networking
network.create_subnet

puts "\n=== Key Takeaway ==="
puts "Abstract Factory creates families of related objects."
puts "Client code depends on interfaces, not concrete classes."
puts "Common uses: UI toolkits, database drivers, cloud providers, themes."
puts "Difference from Factory Method: Abstract Factory creates families, Factory Method creates single products."
