class Device < ManagingRecord
  belongs_to :created_by, class_name: :User, optional: true
  validates_presence_of :name, :MAC

end
