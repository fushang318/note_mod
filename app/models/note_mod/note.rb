module NoteMod
  class Note
    include Mongoid::Document
    include Mongoid::Timestamps
     # title content 不能为空
    field :title,   :type => String
    field :content, :type => String
    validates :title, presence: true
    validates :content, presence: true
    # creator 不能为空
    belongs_to :creator, :class_name => NoteMod.user_class
  end
end