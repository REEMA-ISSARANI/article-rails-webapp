class Like < ActiveRecord::Base

 belongs_to :article

 belongs_to :user

 validates_uniqueness_of :article_id, scope: :user_id


end
