require "openssl"
require "digest/sha1"
require "base64"

module Can
  class Crypto

    CIPHER = "AES-256-CBC"

   def self.encrypt(content, password)
      digest = Digest::SHA1.hexdigest(password)
      cipher = OpenSSL::Cipher.new(CIPHER)
      cipher.encrypt
      cipher.key = digest[0..31]
      cipher.iv  = iv = cipher.random_iv
      encrypted  = cipher.update(content) + cipher.final

      binit = Base64.strict_encode64(iv)
      ilen  = binit.length.to_s
      blen  = Base64.strict_encode64(ilen)
      bdata = Base64.strict_encode64(encrypted)
      # blen + "--" + binit + "--" + bdata
      binit + "--" + bdata
    end

    def self.decrypt(content, password)
      digest = Digest::SHA1.hexdigest(password)
      init, encrypted = content.split("--").map do |v|
        Base64.strict_decode64(v)
      end

      cipher = OpenSSL::Cipher.new(CIPHER)
      cipher.decrypt
      cipher.key = digest[0..31]
      cipher.iv = init

      cipher.update(encrypted) + cipher.final
    end

  end
end
