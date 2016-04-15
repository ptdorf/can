require "json"

module Can
  class Command

    def initialize file, password
      @password = password
      @file = file
    end

    def content
      read()
      @content
    end

    def list
      read()
    end

    def exists name
      data = read()
      data[name] ? true : false
    end

    def get name
      data = read()
      data[name] || nil
    end

    def copy value
      IO.popen("pbcopy", "w") { |cc| cc.write(value) }
      value
    end

    def set name, value
      data = read()
      data[name] = value
      write(data)
    end

    def remove name
      data = read()
      data.delete name
      write(data)
    end

    def encrypt content
      content = Utils.encrypt(content, @password)
      content = Utils.encode(content)
      # content = Utils.neat(content)
    end

    def decrypt content
      # content = Utils.clean(content)
      content = Utils.decode(content)
      content = Utils.decrypt(content, @password)
    end

    private
    def read
      return {} unless File.exist?(@file)

      begin
        content = Utils.read(@file, @password)
      rescue Exception => e
        p e
        content = ""
      end

      abort "Fail to open file." unless content.length > 0
      @content = content
      data = JSON.parse(@content)
    end

    def write data
      content = JSON.dump(data)
      Utils.write(@file, @password, content)
    end

  end
end
