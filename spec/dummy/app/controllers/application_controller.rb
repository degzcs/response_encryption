class ApplicationController < ActionController::Base
  include ResponseEncryption::ActsAsEncryptionController
  include JSONAPI::ActsAsResourceController

  def context
    default_context.merge({
          encoded_symmetric_key: "/XtrzxtbgOYEoVZT3pTG/qhFUrenM4ftn6IqIsemy2c=\n".freeze,
          subdomain: request.headers['Subdomain']
         })
  end
end
