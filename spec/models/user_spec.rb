require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "Should save successfully with everything set" do
      new_user = User.create({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_digest => 'paranormal'
      })

      expect(new_user).to be_valid
    end

    it "Should not save if first name is missing" do
      new_user = User.create({
        :email => 'soap_dodger@gmail.com',
        # :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_digest => 'paranormal'
      })

      expect(new_user).to be_invalid
    end

    it "Should not save if last name is missing" do
      new_user = User.create({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        # :last_name => 'Dodger',
        :password => 'paranormal',
        :password_digest => 'paranormal'
      })

      expect(new_user).to be_invalid
    end

    it "Should not save if email is missing" do
      new_user = User.create({
        # :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_digest => 'paranormal'
      })

      expect(new_user).to be_invalid
    end

    it "Should not save if email already exists" do
      old_user = User.create({
        :email => 'SOAP_DODGER@GMAIL.COM',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_digest => 'paranormal'
      })

      new_user = User.create({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_digest => 'paranormal'
      })

      expect(new_user).to be_invalid
    end

    it "Should not save if passwords do not match" do
      new_user = User.create({
        :email => 'soap_dodger@gmail.com',
        :first_name => 'Soap',
        :last_name => 'Dodger',
        :password => 'paranormal',
        :password_digest => 'hypernormal'
      })

      expect(new_user).to be_invalid
    end

  end
end
