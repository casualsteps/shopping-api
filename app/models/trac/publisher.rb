# == Schema Information
#
# Table name: trac_publishers
#
#  id                       :integer          not null, primary key
#  publisher_name           :string(255)
#  publisher_address        :string(255)
#  publisher_zipcode        :string(255)
#  publisher_telephone_no   :string(255)
#  publisher_login_id       :string(255)
#  publisher_login_password :string(255)
#  publisher_api_key        :string(255)
#  publisher_url            :string(255)
#  deleted_at               :datetime
#  created_at               :datetime
#  updated_at               :datetime
#

class Trac::Publisher < ActiveRecord::Base

end