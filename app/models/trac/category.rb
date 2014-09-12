# == Schema Information
#
# Table name: trac_categories
#
#  id                  :integer          not null, primary key
#  trac_advertisers_id :integer
#  trac_categories_id  :integer
#  category_code       :string(255)
#  deleted_at          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

class Trac::Category < ActiveRecord::Base
  belongs_to  :advertiser
  belongs_to  :category
end
