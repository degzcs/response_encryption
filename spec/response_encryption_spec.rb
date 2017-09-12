require "spec_helper"

RSpec.describe ResponseEncryption do
  it "has a version number" do
    expect(ResponseEncryption::VERSION).not_to be nil
  end
end
