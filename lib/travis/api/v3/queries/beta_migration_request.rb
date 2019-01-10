module Travis::API::V3
  class Queries::BetaMigrationRequest < Query

    def create(current_user)
      current_user.beta_migration_request.create(beta_migration_request_params)
      current_user.save!
    end
  end
end
