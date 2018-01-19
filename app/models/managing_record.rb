class ManagingRecord < ApplicationRecord
  include TrashBin
  include Pages
  self.abstract_class = true
end