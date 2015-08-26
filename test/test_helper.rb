ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# minitest reporter
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false # 預設為true
  # model 測試後會rollback 維持個model的獨立
  # 但使用 myisam或直接用 sql CRUD的會無法 rollback 
  # 所以關掉此功能，寫測試的，記得清除需要清的資料
end
