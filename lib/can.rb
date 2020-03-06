$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + "/../lib"

require "can/store"
require "can/crypto"

module Can
  VERSION = "0.9.12"
end
