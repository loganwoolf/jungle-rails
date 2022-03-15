require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "Validations" do
    before do
      @category = Category.create({
        :name => 'Flying Stuff'
      })
    end

    it "Should save successfully with everything set" do
      new_product = Product.create({

        # are these references to the validator or database ??

        :name => 'Flying saucer ottoman',
        # :price => 69999,
        :price_cents => 69999,
        :quantity => 2,
        # :category => @category
        :category_id => @category.id
      })

      expect(new_product).to be_valid
    end

    it "Should not save successfully if name missing" do
      new_product = Product.create({
        :price_cents => 69999,
        :quantity => 2,
        :category_id => @category.id
      })

      expect(new_product.errors.full_messages).to include("Name can't be blank")
    end

    it "Should not save successfully if price missing" do
      new_product = Product.create({
        :name => 'Flying saucer ottoman',
        :quantity => 2,
        :category_id => @category.id
      })

      expect(new_product.errors.full_messages).to include("Price is not a number")
    end

    it "Should not save successfully if quantity missing" do
      new_product = Product.create({
        :name => 'Flying saucer ottoman',
        :price_cents => 69999,
        :category_id => @category.id
      })

      expect(new_product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "Should not save successfully if category missing" do
      new_product = Product.create({
        :name => 'Flying saucer ottoman',
        :price_cents => 69999,
        :quantity => 2,
      })

      expect(new_product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
