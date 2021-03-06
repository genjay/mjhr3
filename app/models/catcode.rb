class Catcode < ActiveRecord::Base
  validates :m_name,:col_name,:uid,:name,presence:true 
 	validates :uid,:name, uniqueness: { scope: [:ou_id,:m_name,:col_name]	,
    message: "已經被使用" } 

  def self.lists(m_name,col_name) # 下拉選單用 
  	# self.where("m_name='#{m_name}' and col_name='#{col_name}'").pluck("concat(uid,' ',name),uid")
  	self.where(m_name: m_name, col_name: col_name).pluck("concat(uid,' ',name),uid")
  end
  
  def self.sex
  	# x = ['Man','Woman']
  	x = {:Man =>:Man,:Woman =>:Woman}
  end
end
