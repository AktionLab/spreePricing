require File.dirname(__FILE__) + '/../spec_helper'

describe User do

  context "shoulda validations" do
    it { should belong_to(:user_group) }
  end

end
