module NoteMod
  class Note
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :title,   :type => String
    field :content, :type => String

    validates :title, presence: true
    validates :content, presence: true

    belongs_to :creator, class_name: NoteMod.user_class || 'User'
  end
end
