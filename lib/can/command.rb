require "json"
require "time"

module Can
  class Command

    def initialize(file, password)
      @password = password
      @file = file
    end

    def content()
      read()
      @content
    end

    def list()
      read()
    end

    def exists(key)
      data = read()
      data[key] ? true : false
    end

    def get(key)
      data = read()
      data[key] || nil
    end

    def copy(value)
      IO.popen("pbcopy", "w") { |cc| cc.write(value) }
      value
    end

    def set(key, value)
      data = read()
      data[key] = {}
      data[key]["value"] = value
      data[key]["created"] = Time.new
      data[key]["tags"] = []
      write(data)
    end

    def tag(key, tag)
      data = read()
      data[key]["tags"] = data[key]["tags"] || []
      if not data[key]["tags"].include?(tag)
        data[key]["tags"] << tag
        write(data)
        return true
      end
      false
    end

    def untag(key, tag)
      data = read()
      if data[key]["tags"] and data[key]["tags"].include?(tag)
        data[key]["tags"].delete(tag)
        write(data)
        return true
      end
      false
    end

    def remove(key)
      data = read()
      data.delete(key)
      write(data)
    end

    def encrypt(content)
      content = Utils.encrypt(content, @password)
      content = Utils.encode(content)
      # content = Utils.neat(content)
      end

    def decrypt(content)
      # content = Utils.clean(content)
      content = Utils.decode(content)
      content = Utils.decrypt(content, @password)
    end

    def password(pass)
      data = read()
      @password = pass
      write(data)
    end

    def migrate()
      count = 0
      data = JSON.parse(@content)
      data.each do |key, value|
        if value.class == Hash
          # debug "Key #{key} is already migrated."
        else
          data[key] = {}
          data[key]["value"] = value
          data[key]["created"] = Time.new
          data[key]["tags"] = []
          count += 1
        end
      end

      write(data)
      count
    end

    private
    def read()
      return {} unless File.exist?(@file)

      content = Utils.read(@file, @password)
      raise "Error: Fail to open file." unless content and content.length > 0

      @content = content
      data = JSON.parse(@content)
    end

    def write(data)
      content = JSON.dump(data)
      Utils.write(@file, @password, content)
    end

  end
end
