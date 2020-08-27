require "json"
require "time"
# require "zlib"

module Can
  class Store

    HEADER    = "Can"
    SEPARATOR = "\n\n"

    def initialize(file, password)
      @password = password
      @file     = file
      @format   = "1"
    end

    def all()
      read()
    end

    def format()
      @format
    end

    def exists(key)
      data = read()
      data[key] ? true : false
    end

    def get(key)
      data = read()
      data[key] || nil
    end

    def set(key, value)
      data = read()
      data[key] ||= {}
      data[key]["value"] = value
      data[key]["created"] = Time.new
      data[key]["tags"] ||= []
      write(data)
    end

    def tag(key, tag)
      data = read()
      data[key]["tags"] = data[key]["tags"] || []
      if not data[key]["tags"].include?(tag)
        data[key]["tags"] << tag
        return write(data)
      end
      false
    end

    def untag(key, tag)
      data = read()
      if data[key]["tags"] and data[key]["tags"].include?(tag)
        data[key]["tags"].delete(tag)
        return write(data)
      end
      false
    end

    def remove(key)
      data = read()
      data.delete(key)
      write(data)
    end

    def encrypt(payload)
      encrypted = Crypto.encrypt(payload, @password)
      encode(encrypted)
    end

    def decrypt(payload)
      decoded = decode(payload)
      Crypto.decrypt(decoded, @password)
    end

    def password(new_password)
      data = read()
      @password = new_password
      write(data)
    end

    def migrate()
      count = 0
      data = read()
      data.each do |key, value|
        # puts "Checking key #{key}..."
        if value.class != Hash
          data[key] = {}
          data[key]["value"] = value
          data[key]["created"] = Time.new
          data[key]["tags"] = []
          count += 1
          puts "Key #{key} migrated to new format"
        else
          puts "Key #{key} already exists in new format"
        end
      end

      write(data)
      count
    end

    private
    def read()
      return {} unless File.exist?(@file)

      content   = File.read(@file)
      headless  = rm_header(content)
      cleaned   = clean(headless)
      decoded   = decode(cleaned)
      decrypted = Crypto.decrypt(decoded, @password)

      JSON.parse(decrypted)
    end

    def write(data)
      payload   = JSON.dump(data)
      encrypted = Crypto.encrypt(payload, @password)
      encoded   = encode(encrypted)
      aligned   = align(encoded)
      content   = add_header(aligned)

      File.write(@file, content)
    end

    def encode(data)
      data.unpack("H*").first
    end

    def decode(data)
      data.scan(/../).map { |x| x.hex }.pack("c*")
    end

    # def compress(data)
    #   Zlib::Deflate.deflate(data)
    # end

    # def uncompress(data)
    #   Zlib::Inflate.inflate(data)
    # end

    def align(data)
      data.scan(/.{1,64}/).join("\n")
    end

    def clean(data)
      data.split("\n").join("")
    end

    def add_header(payload)
      "#{HEADER}:v#{@format}#{SEPARATOR}#{payload}"
    end

    def rm_header(payload)
      parts  = payload.split(SEPARATOR)
      header = parts[0]
      body   = parts[1]
      m = header.match(/Can\:v(\d+)/)
      @format = m[1]
      body
    end

  end
end
