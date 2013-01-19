class Post < ActiveRecord::Base
  attr_accessible :body, :from

  ACCOUNT_SID = 'AC5c3158c9e08c18f1bd8674a5c9544b42'
  ACCOUNT_TOKEN = '2804511ccef5b294daf82116c75a8f7d'
  CALLER_ID = '+15712978794'
end
