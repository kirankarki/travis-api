module Travis::API::V3
  class Models::BetaMigrationRequest < Model
    belongs_to :owner, polymorphic: true
    after_save :enable_beta

    def enable_beta
      Travis::Features.activate_owner(:allow_migration, owner)
    end
  end
end
