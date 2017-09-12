class ApplicationController < ActionController::Base
  include ResponseEncryption::ActsAsEncryptionController
end
