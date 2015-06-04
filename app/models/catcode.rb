class Catcode < ActiveRecord::Base
	default_scope { where("ou_id is null")}
  validates :m_name,:col_name,:uid,:name,presence:true 
 	validates :uid,:name, uniqueness: { scope: [:ou_id,:m_name,:col_name]	,
    message: "已經被使用" } 

  def self.lists(m_name,col_name) # 下拉選單用 
  	self.where("m_name='#{m_name}' and col_name='#{col_name}'").pluck("concat(uid,' ',name),uid")
  end

end
