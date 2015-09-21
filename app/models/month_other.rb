class MonthOther < ActiveRecord::Base
	belongs_to :employee
	belongs_to :pay_type

	def self.next_docno(ou_id)
		x = self.where(ou_id: ou_id).maximum('doc_no')
		if x == nil
			"#{Time.now.strftime('%Y%m%d')}001"
		else
      x.next
		end
	end

	def get_next 
		self.doc_no = MonthOther.next_docno(ou_id)
	end
	
end
