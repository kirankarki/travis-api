module Travis::API::V3
  class Services::BetaMigrationRequests::Find < Service
    def run!
      user = check_login_and_find(:user)
      result query.find(user)
    end
  end
end
