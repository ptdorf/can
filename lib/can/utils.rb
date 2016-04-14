require "openssl"
require "zlib"
require "base64"
require "digest/sha1"

module Can
  class Utils

    HEADER = "Can:v1\n\n"
    CIPHER = "AES-256-CBC"

    def self.read file, password
      return unless File.exist?(file)

      begin
        content = File.read(file)
        # content = Utils.uncompress(content)
        content = rm_header(content)
        content = clean(content)
        content = decode(content)
        content = decrypt(content, password)
      rescue OpenSSL::Cipher::CipherError => e
        puts "Error: Wrong password."
        content = nil
      rescue Exception => e
        p e
        content = nil
      end
      content
    end

    def self.write file, password, content
      content = encrypt(content, password)
      content = encode(content)
      content = neat(content)
      content = add_header(content)
      # content = Utils.compress(content)
      File.write(file, content)
    end

    def self.digest password
      Digest::SHA1.hexdigest(password)
    end

    def self.encrypt__ content, password
      secret = self.digest(password)
      cipher = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
      cipher.encrypt
      cipher.key = secret
      cipher.iv  = iv = cipher.random_iv
      encrypted  = cipher.update(content) + cipher.final

      bi = Base64.strict_encode64(iv)
      il = bi.length.to_s
      bl = Base64.strict_encode64(il)
      bd = Base64.strict_encode64(encrypted)
      bl + "--" + bi + "--" + bd
    end

    def self.decrypt__ content, password
      secret = self.digest(password)
      il, iv, encrypted = content.split("--").map {|v| Base64.strict_decode64(v)}

      cipher = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
      cipher.decrypt
      cipher.key = secret
      cipher.iv = iv

      cipher.update(encrypted) + cipher.final
    end

   def self.encrypt content, password
      secret = self.digest(password)
      cipher = OpenSSL::Cipher::Cipher.new(CIPHER)
      cipher.encrypt
      cipher.key = secret
      cipher.iv  = iv = cipher.random_iv
      encrypted  = cipher.update(content) + cipher.final

      binit = Base64.strict_encode64(iv)
      ilen  = binit.length.to_s
      blen  = Base64.strict_encode64(ilen)
      bdata = Base64.strict_encode64(encrypted)
      blen + "--" + binit + "--" + bdata
      binit + "--" + bdata
    end

    def self.decrypt content, password
      begin
        secret = self.digest(password)
        init, encrypted = content.split("--").map do |v|
          Base64.strict_decode64(v)
        end

        cipher = OpenSSL::Cipher::Cipher.new(CIPHER)
        cipher.decrypt
        cipher.key = secret
        cipher.iv = init

        cipher.update(encrypted) + cipher.final
      rescue OpenSSL::Cipher::CipherError => e
        puts "NIL"
        nil
      end
    end

    def self.encode data
      data.unpack("H*").first
    end

    def self.decode data
      data.scan(/../).map { |x| x.hex }.pack("c*")
    end

    def self.compress data
      Zlib::Deflate.deflate data
    end

    def self.uncompress data
      Zlib::Inflate.inflate data
    end

    def self.neat data
      data.scan(/.{1,64}/).join("\n")
    end

    def self.clean data
      data.split("\n").join("")
    end

    def self.add_header data
      "#{HEADER}#{data}"
    end

    def self.rm_header data
      data.sub(HEADER, "")
    end

  end
end
