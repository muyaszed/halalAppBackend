class Message
    def self.not_found(record = 'record')
      "Sorry, #{record} not found."
    end

    def self.user_already_exist
      "Sorry, user already exist."
    end
  
    def self.invalid_credentials
      'Invalid credentials'
    end
  
    def self.invalid_token
      'Invalid token'
    end
  
    def self.missing_token
      'Missing token'
    end
  
    def self.unauthorized
      'Unauthorized request'
    end
  
    def self.account_created
      'Account created successfully'
    end
  
    def self.account_not_created
      'Account could not be created'
    end
  
    def self.expired_token
      'Sorry, your token has expired. Please login to continue.'
    end

    def self.invalid_oauth_access_token
      'Invalid OAuth access token.'
    end
  end