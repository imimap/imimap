class CompanyAddress < ApplicationRecord
    belongs_to :company
    has_many :internships
    validates_presence_of :company
end

# city { 'Berlin' }
# country { 'Germany' }
# street { 'Wilhelminenhofstr. 75 A' }
# zip { '12459' }


# city { 'Berlin' }
# country { 'Germany' }
# street { 'Andreasstr. 10' }
# zip { '10243' }
