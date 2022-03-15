require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "Should save successfully with everything set" do
      new_user = User.new({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => 'paranormal'
      })

      expect(new_user).to be_valid
    end

    it "Should not save if first name is missing" do
      new_user = User.new({
        :email => 'soap_dodger@gmail.com',
        # :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => 'paranormal'
      })

      expect(new_user).not_to be_valid
    end

    it "Should not save if last name is missing" do
      new_user = User.new({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        # :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => 'paranormal'
      })

      expect(new_user).not_to be_valid
    end

    it "Should not save if email is missing" do
      new_user = User.new({
        # :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => 'paranormal'
      })

      expect(new_user).not_to be_valid
    end

    it "Should not save if email already exists" do
      old_user = User.create({
        :email => 'SOAP_DODGER@GMAIL.COM',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => 'paranormal'
      })

      new_user = User.new({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => 'paranormal'
      })

      expect(new_user).not_to be_valid
    end

    it "Should not save if passwords do not match" do
      new_user = User.new({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => 'hypernormal'
      })

      expect(new_user).not_to be_valid
    end

    it "Should not save if password confirmation missing" do
      new_user = User.new({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_confirmation => ''
      })
      expect(new_user).not_to be_valid
    end
  end

  describe "Authentication" do
    before do
      new_user = User.create({
        :email => 'Soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'rightpassword',
        :password_confirmation => 'rightpassword'
      })
    end

    it "should return an instance of the authenticated user" do
      compare_user = User.find_by_email('soap_dodger@gmail.com')

      auth_user = User.authenticate_with_credentials('soap_dodger@gmail.com', 'rightpassword')

      # expect(auth_user).to be_an_instance_of User
      expect(auth_user).to eq(compare_user)
    end

    it "should return nil if user not authenticated" do
      auth_user = User.authenticate_with_credentials('soap_dodger@gmail.com', 'wrongpassword')

      expect(auth_user).to be_nil
    end

    it "should log in if email case is different" do
      compare_user = User.find_by_email('soap_dodger@gmail.com')

      auth_user = User.authenticate_with_credentials('sOap_dodger@gmail.com', 'rightpassword')

      # expect(auth_user).to be_an_instance_of User
      expect(auth_user).to eq(compare_user)
    end

    it "should log in if there are extra spaces around email" do
      compare_user = User.find_by_email('soap_dodger@gmail.com')

      auth_user = User.authenticate_with_credentials('  soap_dodger@gmail.com ', 'rightpassword')

      # expect(auth_user).to be_an_instance_of User
      expect(auth_user).to eq(compare_user)
    end
  end

end

# expect(user.password_digest).to eq(BCrypt::Password.new(password))
