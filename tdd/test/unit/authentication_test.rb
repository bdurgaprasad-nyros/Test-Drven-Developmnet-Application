require File.expand_path('../../test_helper.rb', __FILE__)

class AuthenticationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Authentication.new.valid?
  end
end

# == Schema Information
#
# Table name: authentications
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

