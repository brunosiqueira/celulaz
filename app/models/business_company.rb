class BusinessCompany < ActiveRecord::Base
  belongs_to :company
  belongs_to :business
end
